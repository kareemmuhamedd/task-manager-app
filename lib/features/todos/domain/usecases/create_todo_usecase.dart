import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

import '../repositories/todo_repository.dart';

class CreateTodoUseCase
    implements UseCase<TodoDetailsEntity, CreateTodoParams> {
  CreateTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoDetailsEntity>> call(
      CreateTodoParams params) async {
    return await _todoRepository.createTodo(
      TodoDetailsEntity(
        todo: params.todo,
        completed: params.completed,
        userId: params.userId,
      ),
    );
  }
}

class CreateTodoParams {
  final String? todo;
  final bool completed;
  final int? userId;

  CreateTodoParams({
    this.todo,
    this.completed = false,
    this.userId,
  });
}
