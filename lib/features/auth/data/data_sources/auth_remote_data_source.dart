// File: lib/features/auth/data/data_sources/auth_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/features/auth/data/models/profile_model.dart';
import 'package:management_tasks_app/shared/networking/api_constants.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthModel> signIn({
    required String userName,
    required String password,
  });

  Future<ProfileModel> currentUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<AuthModel> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/auth/login',
        data: {'username': userName, 'password': password},
      );
      return AuthModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<ProfileModel> currentUser() async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}/auth/me');
      return ProfileModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }
}