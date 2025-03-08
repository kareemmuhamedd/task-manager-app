import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:management_tasks_app/features/auth/data/mappers/profile_mapper.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:management_tasks_app/shared/networking/connection_checker.dart';

import '../../../../shared/errors/custom_error_handler.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../mappers/auth_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectionChecker connectionChecker,
    required ProfileLocalDataSource profileLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _connectionChecker = connectionChecker,
        _profileLocalDataSource = profileLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;
  final ConnectionChecker _connectionChecker;

  @override
  Future<Either<ApiError, AuthEntity>> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      final authModel = await _authRemoteDataSource.signIn(
        userName: userName,
        password: password,
      );
      final authEntity = AuthMapper.toEntity(authModel);
      return Right(authEntity);
    } on ApiError catch (error) {
      // Catch specific error type
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, ProfileEntity>> currentUser() async {
    try {
      if (!await _connectionChecker.isConnected) {
        final profileModel = await _profileLocalDataSource.getProfile();
        if (profileModel == null) {
          return Left(ApiError(
            statusCode: 404,
            message: 'No local profile available',
            errorType: 'NoLocalProfile',
          ));
        }
        final profileEntity = ProfileMapper.fromModel(profileModel);
        return Right(profileEntity);
      }

      final profileModel = await _authRemoteDataSource.currentUser();
      final profileEntity = ProfileMapper.fromModel(profileModel);

      // Save to local storage
      await _profileLocalDataSource.saveProfile(profileModel);

      return Right(profileEntity);
    } on ApiError catch (error) {
      return Left(error);
    } catch (e) {
      return Left(ApiError(
        statusCode: 500,
        message: 'Unexpected error: ${e.toString()}',
        errorType: 'UnexpectedError',
      ));
    }
  }
}
