import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';

abstract interface class AuthRepository {
  Future<Either<ApiError, AuthEntity>> signIn({
    required String userName,
    required String password,
  });

  Future<Either<ApiError, ProfileEntity>> currentUser();
}
