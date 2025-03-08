// File: test/features/data/auth_remote_data_source_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/auth/data/models/profile_model.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/networking/api_constants.dart';

import '../../../utilities/json_reader.dart';
import '../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late final Dio mockDio;
  late final AuthRemoteDataSourceImpl mockAuthRemoteDataSourceImpl;
  late final AuthModel mockAuthModel;
  late final ProfileModel mockProfileModel;
  late final dynamic authJson;
  late final dynamic profileJson;

  setUpAll(() {
    mockDio = MockDio();
    mockAuthRemoteDataSourceImpl = AuthRemoteDataSourceImpl(dio: mockDio);
    authJson = jsonReader('auth_fake_data.json');
    profileJson = jsonReader('profile_fake_data.json');
    mockAuthModel = AuthModel.fromJson(authJson as Map<String, dynamic>);
    mockProfileModel = ProfileModel.fromJson(profileJson as Map<String, dynamic>);
  });

  group('login', () {
    late final Response<dynamic> response;
    late final Exception exception;

    setUpAll(() {
      exception = Exception('Error');
      response = Response<dynamic>(
        data: authJson,
        requestOptions: RequestOptions(
          path: '${ApiConstants.baseUrl}/auth/login',
        ),
      );
    });

    test('this test should return an auth model when the call of auth remote data source is success', () async {
      when(mockDio.post(
        '${ApiConstants.baseUrl}/auth/login',
        data: {
          'username': 'kemo',
          'password': 'kemo123',
        },
      )).thenAnswer((_) async => response);

      final result = await mockAuthRemoteDataSourceImpl.signIn(
        userName: 'kemo',
        password: 'kemo123',
      );

      expect(result, isA<AuthModel>());
      expect(result, equals(mockAuthModel));
    });

    test('this test should throw an error when the call of auth remote data source fails', () async {
      when(mockDio.post(
        '${ApiConstants.baseUrl}/auth/login',
        data: {
          'username': 'kemo',
          'password': 'kemo123',
        },
      )).thenThrow(DioError(requestOptions: RequestOptions(path: '${ApiConstants.baseUrl}/auth/login')));

      expect(
            () async => await mockAuthRemoteDataSourceImpl.signIn(
          userName: 'kemo',
          password: 'kemo123',
        ),
        throwsA(isA<ApiError>()),
      );
    });
  });
}