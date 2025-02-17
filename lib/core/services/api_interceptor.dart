import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import '../errors/server_failure.dart';
import '../utils/end_point.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  bool isRefreshing = false;
  final List<Completer<Response>> requestQueue = [];

  ApiInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = Prefs.getString(EndPoint.token);
    if (token.isNotEmpty ) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final completer = Completer<Response>();
      requestQueue.add(completer);

      if (!isRefreshing) {
        isRefreshing = true;

        _refreshToken().then((newToken) {
          // 1️⃣ تحديث التوكن في Prefs مباشرة بعد التحديث
          Prefs.setString(EndPoint.token, newToken);
          _retryPendingRequests();
        }).catchError((_) {
          // 2️⃣ في حالة الفشل، احذف التوكن لمنع استخدامه
          Prefs.remove(EndPoint.token);
          for (var request in requestQueue) {
            request.completeError(err);
          }
          requestQueue.clear();
          handler.reject(err);
        }).whenComplete(() {
          isRefreshing = false;
        });
      }

      completer.future.then((response) {
        handler.resolve(response);
      }).catchError((_) {
        handler.reject(err);
      });

      return;
    }

    handler.next(err);
  }

  Future<String> _refreshToken() async {
    try {
      String? refreshToken = Prefs.getString(EndPoint.refreshToken);
      final response = await dio.get(
        "${EndPoint.baseUrl}auth/refresh-token?token=$refreshToken",
      );

      final String newToken = response.data['access_token'];
      return newToken;
    } catch (e) {
      throw const ServerFailure("Failed to refresh token");
    }
  }

  void _retryPendingRequests() {
    final String newToken = Prefs.getString(EndPoint.token);

    while (requestQueue.isNotEmpty) {
      final request = requestQueue.removeAt(0);
      request.complete(_retryRequest(request.future as RequestOptions, newToken));
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions, String newToken) async {
    // 3️⃣ تأكد من أن الطلب يستخدم التوكن الجديد قبل إعادة إرساله
    requestOptions.headers["Authorization"] = "Bearer $newToken";
    return await dio.fetch(requestOptions);
  }
}




