import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthEntity, UserLoginParams> {
  LoginUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  Future<Either<ApiError, AuthEntity>> call(UserLoginParams params) async {
    return await _authRepository.signIn(
      userName: params.userName,
      password: params.password,
    );
  }
}

class UserLoginParams extends Equatable {
  final String userName;
  final String password;

  UserLoginParams({
    required this.userName,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userName, password];

}
