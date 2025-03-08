import 'package:either_dart/either.dart';

import '../../../../shared/errors/custom_error_handler.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/todo_details_entity.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUseCase
    implements UseCase<TodoDetailsEntity, DeleteTodoParams> {
  DeleteTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<ApiError, TodoDetailsEntity>> call(
      DeleteTodoParams params) async {
    return await _todoRepository.deleteTodoById(params.id);
  }
}

class DeleteTodoParams {
  final int id;

  DeleteTodoParams({
    required this.id,
  });
}
