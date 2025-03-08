import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

import '../entities/todo_entity.dart';

class GetTodoByIdUseCase implements UseCase<TodoEntity, GetTodoByIdParams> {
  GetTodoByIdUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoEntity>> call(GetTodoByIdParams params) async {
    return _todoRepository.getTodoById(params.id);
  }
}

class GetTodoByIdParams {
  final int id;

  GetTodoByIdParams({
    required this.id,
  });
}
