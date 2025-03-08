// File: test/features/auth/domain/usecases/login_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/auth/data/mappers/auth_mapper.dart';
import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/json_reader.dart';
import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(authRepository: mockAuthRepository);
    provideDummy<Either<ApiError, AuthEntity>>(Right(AuthEntity()));
  });

  const tUserName = 'testuser';
  const tPassword = 'password123';
  final tUserLoginParams = UserLoginParams(userName: tUserName, password: tPassword);
  final authJson = jsonReader('auth_fake_data.json');
  final tAuthModel = AuthModel.fromJson(authJson as Map<String, dynamic>);
  final tAuthEntity = AuthMapper.toEntity(tAuthModel);

  test('should return AuthEntity when the call to AuthRepository is successful', () async {
    // arrange
    when(mockAuthRepository.signIn(userName: anyNamed('userName'), password: anyNamed('password')))
        .thenAnswer((_) async => Right(tAuthEntity));
    // act
    final result = await useCase(tUserLoginParams);
    // assert
    verify(mockAuthRepository.signIn(userName: tUserName, password: tPassword));
    expect(result, Right(tAuthEntity));
  });

  test('should return ApiError when the call to AuthRepository is unsuccessful', () async {
    // arrange
    final tError = ApiError(message: 'Invalid credentials', statusCode: 401, details: null, errorType: 'AUTH_ERROR');
    when(mockAuthRepository.signIn(userName: anyNamed('userName'), password: anyNamed('password')))
        .thenAnswer((_) async => Left(tError));
    // act
    final result = await useCase(tUserLoginParams);
    // assert
    verify(mockAuthRepository.signIn(userName: tUserName, password: tPassword));
    expect(result, Left(tError));
  });
}