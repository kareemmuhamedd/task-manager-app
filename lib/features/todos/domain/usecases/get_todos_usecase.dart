import 'package:either_dart/either.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase implements UseCase<TodoEntity, NoParams> {
  GetTodosUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoEntity>> call(NoParams params) async {
    return await _todoRepository.getTodos();
  }
}
