import 'package:dio/dio.dart';
import 'package:tasky/core/services/shered_preferences_singleton.dart';
import '../errors/server_failure.dart';
import '../utils/end_point.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio = Dio(); // تأكد من أن Dio مهيأ بشكل صحيح
  bool isRefreshing = false;
  final List<Function()> requestQueue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // استرجاع التوكن من الكاش
    String? token = Prefs.getString(EndPoint.token);

    if (token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    // تمرير الطلب بعد تعديل الـ headers
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) async {
    // في حالة انتهاء صلاحية التوكن (Unauthorized)
    if (e.response?.statusCode == 401) {
      if (!isRefreshing) {
        isRefreshing = true;
        try {
          String newToken = await _refreshToken();
          Prefs.setString(EndPoint.token, newToken); // حفظ التوكن الجديد

          // إعادة تنفيذ الطلبات المعلقة
          for (var retryRequest in requestQueue) {
            retryRequest();
          }
          requestQueue.clear();
        } catch (_) {
          Prefs.remove(EndPoint.token); // مسح التوكن عند الفشل
        }
        isRefreshing = false;
      }

      // حفظ الطلب لإعادة تنفيذه بعد تحديث التوكن
      final requestOptions = e.requestOptions;
      requestQueue.add(() {
        dio.fetch(requestOptions);
      });

      return;
    }

    // تمرير الخطأ إلى باقي البرنامج
    super.onError(e, handler);
  }

  Future<String> _refreshToken() async {
    try {
      String? oldToken = Prefs.getString(EndPoint.token);
      final response = await dio.post("${EndPoint.baseUrl}auth/refresh-token?token=$oldToken");

      return response.data['token'];
    } catch (e) {
      throw const ServerFailure("Failed to refresh token");
    }
  }
}
