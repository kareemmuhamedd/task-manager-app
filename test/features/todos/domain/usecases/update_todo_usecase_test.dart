// File: test/features/todos/domain/usecases/update_todo_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late UpdateTodoUseCase useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = UpdateTodoUseCase(todoRepository: mockTodoRepository);
    provideDummy<Either<ApiError, TodoDetailsEntity>>(Right(TodoDetailsEntity(todo: '', completed: false, userId: 0)));
  });

  final tTodo = 'Updated Todo';
  final tCompleted = true;
  final tUserId = 1;
  final tTodoId = 123;
  final tTodoDetailsEntity = TodoDetailsEntity(
    todo: tTodo,
    completed: tCompleted,
    userId: tUserId,
    id: tTodoId,
  );
  final tParams = UpdateTodoParams(
    todo: tTodoDetailsEntity,
    completed: tCompleted,
    todoId: tTodoId,
  );

  test('should return TodoDetailsEntity when the call to TodoRepository is successful', () async {
    // arrange
    when(mockTodoRepository.updateTodo(
      any,
      any,
    )).thenAnswer((_) async => Right(tTodoDetailsEntity));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.updateTodo(
      tTodoDetailsEntity,
      tTodoId,
    ));
    expect(result, Right(tTodoDetailsEntity));
  });

  test('should return ApiError when the call to TodoRepository is unsuccessful', () async {
    // arrange
    final tError = ApiError(message: 'Error updating todo', errorType: 'UPDATE_TODO_ERROR');
    when(mockTodoRepository.updateTodo(
      any,
      any,
    )).thenAnswer((_) async => Left(tError));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.updateTodo(
      tTodoDetailsEntity,
      tTodoId,
    ));
    expect(result, Left(tError));
  });
}