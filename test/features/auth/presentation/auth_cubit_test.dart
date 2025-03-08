// File: test/features/auth/presentation/cubit/auth_cubit_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/auth/data/mappers/auth_mapper.dart';
import 'package:management_tasks_app/features/auth/data/mappers/profile_mapper.dart';
import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/features/auth/data/models/profile_model.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:management_tasks_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../utilities/json_reader.dart';
import '../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late AuthCubit authCubit;
  late MockLoginUseCase mockLoginUseCase;
  late AuthEntity tAuthEntity;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  final authJson = jsonReader('auth_fake_data.json');
  final profileJson = jsonReader('profile_fake_data.json');
  final tAuthModel = AuthModel.fromJson(authJson as Map<String, dynamic>);
  final tProfileModel =
      ProfileModel.fromJson(profileJson as Map<String, dynamic>);
  final tProfileEntity = ProfileMapper.fromModel(tProfileModel);

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();

    tAuthEntity = AuthMapper.toEntity(tAuthModel);
    authCubit = AuthCubit(
      loginUseCase: mockLoginUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
    );
    provideDummy<Either<ApiError, AuthEntity>>(
        const Right(AuthEntity(accessToken: '', refreshToken: '', id: 0)));
  });

  blocTest<AuthCubit, AuthState>(
    'this bloc test should emit AuthLoading AND AuthSuccess when login is successful',
    build: () {
      provideDummy<Either<ApiError, AuthEntity>>(Right(tAuthEntity));
      when(mockLoginUseCase
              .call(UserLoginParams(userName: 'kemo', password: 'kemo123')))
          .thenAnswer((_) async => Right(tAuthEntity));
      return authCubit;
    },
  );

  blocTest<AuthCubit, AuthState>(
    'emits [loading, success, idle] when getCurrentUser is called and successful',
    build: () {
      provideDummy<Either<ApiError, ProfileEntity>>(Right(tProfileEntity));
      when(mockGetCurrentUserUseCase.call(any))
          .thenAnswer((_) async => Right(tProfileEntity));
      return AuthCubit(
        loginUseCase: mockLoginUseCase,
        getCurrentUserUseCase: mockGetCurrentUserUseCase,
      );
    },
    act: (cubit) => cubit.getCurrentUser(),
    expect: () => [
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.loading),
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.success),
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.idle),
    ],
    tearDown: () async => authCubit.close(),
  );

  blocTest<AuthCubit, AuthState>(
    'emits [loading, error, idle] when getCurrentUser is called and fails',
    build: () {
      provideDummy<Either<ApiError, ProfileEntity>>(Left(ApiError(
        message: 'error',
        statusCode: 500,
        errorType: 'SERVER_ERROR',
      )));
      when(mockGetCurrentUserUseCase.call(any))
          .thenAnswer((_) async => Left(ApiError(
                message: 'error',
                statusCode: 500,
                errorType: 'SERVER_ERROR',
              )));
      return AuthCubit(
        loginUseCase: mockLoginUseCase,
        getCurrentUserUseCase: mockGetCurrentUserUseCase,
      );
    },
    act: (cubit) => cubit.getCurrentUser(),
    expect: () => [
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.loading),
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.error),
      isA<AuthState>().having(
          (state) => state.status, 'status', LogInSubmissionStatus.idle),
    ],
    tearDown: () async => authCubit.close(),
  );
}
