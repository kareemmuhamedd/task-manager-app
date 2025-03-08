import 'package:either_dart/either.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';


abstract interface class UseCase<SuccessType, Params> {
  Future<Either<ApiError, SuccessType>> call(Params params);
}

class NoParams {}
