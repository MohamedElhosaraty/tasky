import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import '../errors/server_failure.dart';
import '../utils/end_point.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  bool isRefreshing = false;
  final List<Map<String, dynamic>> requestQueue = []; // قائمة الطلبات المعلقة

  ApiInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = Prefs.getString(EndPoint.token);
    if (token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final completer = Completer<Response>();
      requestQueue.add({"completer": completer, "requestOptions": err.requestOptions});

      if (!isRefreshing) {
        isRefreshing = true;

        _refreshToken().then((newToken) {
          Prefs.setString(EndPoint.token, newToken);
          _retryPendingRequests(newToken);
        }).catchError((_) {
          Prefs.remove(EndPoint.token);
          requestQueue.forEach((item) => (item["completer"] as Completer).completeError(err));
          requestQueue.clear();
        }).whenComplete(() {
          isRefreshing = false;
        });
      }

      completer.future.then((response) {
        handler.resolve(response);
      }).catchError((error) {
        handler.reject(DioException(requestOptions: err.requestOptions, error: error));
      });

      return;
    }

    handler.next(err);
  }

  /// تحديث التوكن باستخدام `refreshToken`
  Future<String> _refreshToken() async {
    try {
      String? refreshToken = Prefs.getString(EndPoint.refreshToken);
      if (refreshToken.isEmpty) {
        throw const ServerFailure("لا يوجد توكن تحديث متاح");
      }

      final response = await dio.get(
        "${EndPoint.baseUrl}auth/refresh-token?token=$refreshToken",
      );

      return response.data['access_token'];
    } catch (e) {
      throw ServerFailure("فشل تحديث التوكن: ${e.toString()}");
    }
  }

  /// إعادة إرسال جميع الطلبات المعلقة بعد تحديث التوكن
  void _retryPendingRequests(String newToken) {
    while (requestQueue.isNotEmpty) {
      final requestItem = requestQueue.removeAt(0);
      _retryRequest(requestItem["requestOptions"], newToken, requestItem["completer"]);
    }
  }

  /// إعادة إرسال الطلب باستخدام التوكن الجديد
  Future<void> _retryRequest(RequestOptions requestOptions, String newToken, Completer<Response> completer) async {
    try {
      requestOptions.headers["Authorization"] = "Bearer $newToken";
      final response = await dio.fetch(requestOptions);
      completer.complete(response); // إرجاع الاستجابة بعد نجاح الطلب
    } catch (e) {
      completer.completeError(e); // إرجاع الخطأ إذا فشل الطلب
    }
  }
}
