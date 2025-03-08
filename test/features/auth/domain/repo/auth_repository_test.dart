// File: test/features/auth/data/repositories/auth_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/auth/data/mappers/auth_mapper.dart';
import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/json_reader.dart';
import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockConnectionChecker mockConnectionChecker;
  late MockProfileLocalDataSource mockProfileLocalDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockConnectionChecker = MockConnectionChecker();
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockAuthRemoteDataSource,
      connectionChecker: mockConnectionChecker,
      profileLocalDataSource: mockProfileLocalDataSource,
    );
  });

  group('signIn', () {
    const tUserName = 'test';
    const tPassword = 'password';
    final authJson = jsonReader('auth_fake_data.json');
    final tAuthModel = AuthModel.fromJson(authJson as Map<String, dynamic>);
    final tAuthEntity = AuthMapper.toEntity(tAuthModel);

    test(
        'should return AuthEntity when the call to remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.signIn(
              userName: anyNamed('userName'), password: anyNamed('password')))
          .thenAnswer((_) async => tAuthModel);
      // act
      final result =
          await repository.signIn(userName: tUserName, password: tPassword);
      // assert
      verify(mockAuthRemoteDataSource.signIn(
          userName: tUserName, password: tPassword));
      expect(result, Right(tAuthEntity));
    });

    test(
        'should return Left<ApiError, dynamic> when the call to remote data source is unsuccessful',
        () async {
      // arrange
      final tError = ApiError(
          message: 'Bad Request', statusCode: 400, errorType: 'HTTP400');
      when(mockAuthRemoteDataSource.signIn(
              userName: anyNamed('userName'), password: anyNamed('password')))
          .thenThrow(tError);
      // act
      final result =
          await repository.signIn(userName: tUserName, password: tPassword);
      // assert
      verify(mockAuthRemoteDataSource.signIn(
          userName: tUserName, password: tPassword));
      expect(result, Left<ApiError, dynamic>(tError));
    });
  });
}
