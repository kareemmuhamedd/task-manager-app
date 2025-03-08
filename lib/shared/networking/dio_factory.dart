import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utilities/local_storage/secure_storage_service.dart';
import 'api_constants.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    const timeOut = Duration(seconds: 30);

    if (dio == null) {
      dio = Dio()
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioHeaders();
      addDioInterceptor();

      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    final token = await SecureStorageHelper.instance.getString('access_token');
    print(token);
    dio?.options.headers['Authorization'] =
        token != null ? 'Bearer $token' : null;
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await SecureStorageHelper.instance.getString('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              /// Handle token refresh
              /// we will know that access token is expired because of 401 status code
              /// here if token is expired then we will refresh the token
              /// and then retry the failed request
              await refreshToken();

              /// Here we are retrying the failed request with the new access token
              final newToken =
                  await SecureStorageHelper.instance.getString('access_token');
              if (newToken != null) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';

                final retryResponse = await dio!.request(
                  error.requestOptions.path,
                  options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers,
                  ),
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(retryResponse);
              }
            } catch (e) {
              /// If token refresh fails then we will reject the request
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  static Future<void> refreshToken() async {
    try {
      /// Get refresh token from shared pref
      final refreshToken =
          await SecureStorageHelper.instance.getString('refresh_token');
      if (refreshToken == null) {
        throw Exception("No refresh token available");
      }

      /// Make a request to refresh token and get new access token and save it in shared pref
      final response = await dio!.post(
        '${ApiConstants.baseUrl}/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        await SecureStorageHelper.instance
            .setString('access_token', newAccessToken);
        dio?.options.headers['Authorization'] = 'Bearer $newAccessToken';
      } else {
        throw Exception("Failed to refresh token: ${response.data}");
      }
    } catch (e) {
      throw Exception("Token refresh failed: $e");
    }
  }
}
