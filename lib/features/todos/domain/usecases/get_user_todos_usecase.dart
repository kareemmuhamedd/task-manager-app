import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

class GetUserTodosUseCase implements UseCase<TodoEntity, GetUserTodosParams> {
  GetUserTodosUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoEntity>> call(GetUserTodosParams params) async {
    return await _todoRepository.getUserTodos(params.userId);
  }
}

class GetUserTodosParams {
  final int userId;

  GetUserTodosParams({
    required this.userId,
  });
}
