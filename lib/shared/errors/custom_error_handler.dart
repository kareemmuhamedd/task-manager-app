import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiError {
  final String message;
  final int? statusCode;
  final dynamic details;
  final String errorType;

  ApiError({
    required this.message,
    this.statusCode,
    this.details,
    required this.errorType,
  });

  @override
  String toString() => '[$errorType] ${statusCode ?? ''}: $message';
}

class CustomErrorHandler {
  //static final Logger _logger = Logger();
  static String networkError = 'No internet connection';
  static String defaultError = 'Something went wrong';
  static String timeoutError = 'Request timed out';
  static String serverError = 'Server error occurred';
  static String parsingError = 'Data parsing failed';
  static String unexpectedError = 'Unexpected error occurred';

  // Configure these based on your API's error response structure
  static List<String> messageKeys = ['message', 'error', 'description'];
  static String codeKey = 'code';
  static String detailsKey = 'details';

  static Future<ApiError> handleError(dynamic error) async {
    //_logger.e('Error occurred', error: error);

    if (error is DioException) {
      return await _handleDioError(error);
    } else if (error is FormatException) {
      return ApiError(
        message: parsingError,
        details: error.message,
        errorType: 'FormatException',
      );
    }

    return ApiError(
      message: unexpectedError,
      details: error.toString(),
      errorType: 'Unknown',
    );
  }

  static Future<ApiError> _handleDioError(DioException error) async {
    final type = error.type;
    final response = error.response;

    switch (type) {
      case DioExceptionType.cancel:
        return ApiError(
          message: 'Request cancelled',
          errorType: 'RequestCancelled',
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(
            message: timeoutError,
            statusCode: response?.statusCode,
            errorType: 'Timeout');
      case DioExceptionType.badCertificate:
        return ApiError(
          message: 'Invalid security certificate',
          errorType: 'BadCertificate',
        );
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      case DioExceptionType.connectionError:
        if (await _isConnectionAvailable()) {
          return ApiError(
            message: serverError,
            statusCode: 503,
            errorType: 'ServerUnreachable',
          );
        }
        return ApiError(
          message: networkError,
          errorType: 'NoInternet',
        );
      default:
        return ApiError(
          message: unexpectedError,
          details: error.error?.toString(),
          errorType: 'Unexpected',
        );
    }
  }

  static ApiError _handleResponseError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    // Try to parse API error response
    try {
      final apiError = _parseApiError(response?.data);
      return ApiError(
        message: apiError.message ?? defaultError,
        statusCode: statusCode,
        details: apiError.details,
        errorType: apiError.code ?? 'APIError',
      );
    } catch (e) {
      //_logger.e('Failed to parse error response', error: e);
    }

    // Fallback to status code handling
    final message = _getStatusCodeMessage(statusCode);
    return ApiError(
      message: message,
      statusCode: statusCode,
      errorType: 'HTTP$statusCode',
    );
  }

  static ({String? message, String? code, dynamic details}) _parseApiError(
      dynamic data) {
    if (data is Map<String, dynamic>) {
      return (
        message: _getMessageFromKeys(data),
        code: data[codeKey]?.toString(),
        details: data[detailsKey],
      );
    }

    if (data is String) {
      return (
        message: data.isNotEmpty ? data : null,
        code: null,
        details: null
      );
    }

    return (message: null, code: null, details: data);
  }

  static String _getMessageFromKeys(Map<String, dynamic> data) {
    for (final key in messageKeys) {
      final value = data[key];
      if (value != null) {
        if (value is List) return value.first.toString();
        if (value is Map) return value.values.first.toString();
        return value.toString();
      }
    }
    return defaultError;
  }

  static String _getStatusCodeMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request';
      case 401:
        return 'Unauthorized access';
      case 403:
        return 'Forbidden operation';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal server error';
      default:
        return defaultError;
    }
  }

  static Future<bool> _isConnectionAvailable() async {
    try {
      final results = await Connectivity().checkConnectivity();
      return results.isNotEmpty &&
          results.any((result) => result != ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }
}
