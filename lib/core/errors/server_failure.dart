import 'package:dio/dio.dart';

import 'failures.dart';

/// **فشل في الاتصال بالخادم**
class ServerFailure extends Failure {
  const ServerFailure(super.message);

  /// **إنشاء `ServerFailure` بناءً على خطأ `DioError`**
  factory ServerFailure.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timed out. Please try again.');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send request timed out. Please try again.');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive response timed out. Please try again.');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Invalid security certificate. Connection blocked.');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(error.response);

      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled. Please retry.');

      case DioExceptionType.connectionError:
        return const ServerFailure('No internet connection. Check your network.');

      case DioExceptionType.unknown:
      default:
        return const ServerFailure('Unexpected error occurred. Please try again later.');
    }
  }

  /// **تحليل استجابة HTTP ومعرفة السبب**
  factory ServerFailure.fromResponse(Response<dynamic>? response) {
    if (response == null || response.statusCode == null) {
      return const ServerFailure('Unknown server error. Please try again.');
    }

    final int statusCode = response.statusCode!;
    final dynamic responseData = response.data;

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        final String message = _extractErrorMessage(responseData) ??
            'Authentication or permission error. Please check your credentials.';
        return ServerFailure(message);

      case 404:
        return const ServerFailure('Requested resource not found.');

      case 500:
        return const ServerFailure('Internal server error. Please try again later.');

      default:
        return ServerFailure('Unexpected error: HTTP $statusCode. Please try again.');
    }
  }

  /// **استخراج رسالة الخطأ من `response.data` بطريقة ديناميكية**
  static String? _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('error')) {
        if (responseData['error'] is String) {
          return responseData['error'];
        } else if (responseData['error'] is Map<String, dynamic> &&
            responseData['error'].containsKey('message')) {
          return responseData['error']['message'].toString();
        }
      }
    }
    return null;
  }
}

/// **فشل في الاتصال بالإنترنت**
class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection. Please check your network.');

  @override
  String toString() => "NetworkFailure: $message";
}

/// **خطأ غير متوقع**
class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super('An unexpected error occurred.');

  @override
  String toString() => "UnexpectedFailure: $message";
}
