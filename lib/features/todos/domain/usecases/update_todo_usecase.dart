import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

class UpdateTodoUseCase
    implements UseCase<TodoDetailsEntity, UpdateTodoParams> {
  UpdateTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoDetailsEntity>> call(
      UpdateTodoParams params) async {
    return await _todoRepository.updateTodo(
      TodoDetailsEntity(
        todo: params.todo.todo,
        completed: params.completed,
        userId: params.todo.userId,
        id: params.todoId,
      ),
      params.todoId,
    );
  }
}

class UpdateTodoParams {
  final TodoDetailsEntity todo;
  final bool completed;
  final int todoId;

  UpdateTodoParams({
    required this.todo,
    required this.completed,
    required this.todoId,
  });
}
