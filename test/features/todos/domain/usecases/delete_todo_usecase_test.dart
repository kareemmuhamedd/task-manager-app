// File: test/features/todos/domain/usecases/delete_todo_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/delete_todo_usecase.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late DeleteTodoUseCase useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = DeleteTodoUseCase(todoRepository: mockTodoRepository);
    provideDummy<Either<ApiError, TodoDetailsEntity>>(Right(TodoDetailsEntity(todo: '', completed: false, userId: 0)));
  });

  final tTodoId = 123;
  final tTodoDetailsEntity = TodoDetailsEntity(
    todo: 'Test Todo',
    completed: false,
    userId: 1,
    id: tTodoId,
  );

  test('should return TodoDetailsEntity when the call to TodoRepository is successful', () async {
    // arrange
    when(mockTodoRepository.deleteTodoById(any))
        .thenAnswer((_) async => Right(tTodoDetailsEntity));
    // act
    final result = await useCase(DeleteTodoParams(id: tTodoId));
    // assert
    verify(mockTodoRepository.deleteTodoById(tTodoId));
    expect(result, Right(tTodoDetailsEntity));
  });

  test('should return ApiError when the call to TodoRepository is unsuccessful', () async {
    // arrange
    final tError = ApiError(message: 'Error deleting todo', errorType: 'DELETE_TODO_ERROR');
    when(mockTodoRepository.deleteTodoById(any))
        .thenAnswer((_) async => Left(tError));
    // act
    final result = await useCase(DeleteTodoParams(id: tTodoId));
    // assert
    verify(mockTodoRepository.deleteTodoById(tTodoId));
    expect(result, Left(tError));
  });
}