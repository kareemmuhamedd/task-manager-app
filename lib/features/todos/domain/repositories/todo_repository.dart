import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';

abstract interface class TodoRepository {
  Future<Either<ApiError, TodoEntity>> getTodos();

  Future<Either<ApiError, TodoEntity>> getTodoById(int id);

  Future<Either<ApiError, TodoEntity>> getRandomTodo();

  Future<Either<ApiError, TodoEntity>> getPaginationTodos({
    required int limit,
    required int skip,
  });

  Future<Either<ApiError, TodoEntity>> getUserTodos(int userId);

  Future<Either<ApiError, TodoDetailsEntity>> createTodo(
      TodoDetailsEntity todo);

  Future<Either<ApiError, TodoDetailsEntity>> updateTodo(
    TodoDetailsEntity todo,
    int todoId,
  );

  Future<Either<ApiError, TodoDetailsEntity>> deleteTodoById(int id);
}
