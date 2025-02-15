import 'package:dio/dio.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import '../errors/server_failure.dart';
import '../utils/end_point.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  bool isRefreshing = false;
  final List<Function()> requestQueue = [];

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
      if (!isRefreshing) {
        isRefreshing = true;

        try {
          String newToken = await _refreshToken();
          Prefs.setString(EndPoint.token, newToken);

          // إعادة تنفيذ جميع الطلبات المعلقة
          for (var retryRequest in requestQueue) {
            retryRequest();
          }
          requestQueue.clear();
        } catch (_) {
          Prefs.remove(EndPoint.token);
          requestQueue.clear();
          handler.reject(err);
        }

        isRefreshing = false;
      }

      // إضافة الطلب إلى قائمة الانتظار
      requestQueue.add(() async {
        final Response<dynamic> retryResponse = await _retryRequest(err.requestOptions);
        handler.resolve(retryResponse);
      });

      return;
    }

    handler.next(err);
  }

  Future<String> _refreshToken() async {
    try {
      String? oldToken = Prefs.getString(EndPoint.token);
      final response = await dio.get("${EndPoint.baseUrl}auth/refresh-token?token=$oldToken");

      return response.data['token'];
    } catch (e) {
      throw const ServerFailure("Failed to refresh token");
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final String newToken = Prefs.getString(EndPoint.token);
    requestOptions.headers["Authorization"] = "Bearer $newToken";

    return await dio.fetch(requestOptions);
  }
}
