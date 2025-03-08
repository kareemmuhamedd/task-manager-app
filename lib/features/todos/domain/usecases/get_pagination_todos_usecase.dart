import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/usecase/usecase.dart';

class GetPaginationTodosUseCase
    implements UseCase<TodoEntity, GetPaginationTodosParams> {
  GetPaginationTodosUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoEntity>> call(
      GetPaginationTodosParams params) async {
    return await _todoRepository.getPaginationTodos(
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetPaginationTodosParams {
  final int limit;
  final int skip;

  GetPaginationTodosParams({
    required this.limit,
    required this.skip,
  });
}
