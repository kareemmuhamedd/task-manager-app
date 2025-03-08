import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';

import '../../../../shared/usecase/usecase.dart';

class GetCurrentUserUseCase implements UseCase<ProfileEntity, NoParams> {
  GetCurrentUserUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  Future<Either<ApiError, ProfileEntity>> call(NoParams params) {
    return _authRepository.currentUser();
  }
}
