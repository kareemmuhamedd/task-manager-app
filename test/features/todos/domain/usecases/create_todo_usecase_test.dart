// File: test/features/todos/domain/usecases/create_todo_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/create_todo_usecase.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late CreateTodoUseCase useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = CreateTodoUseCase(todoRepository: mockTodoRepository);
    provideDummy<Either<ApiError, TodoDetailsEntity>>(Right(TodoDetailsEntity(todo: '', completed: false, userId: 0)));
  });

  final tTodo = 'Test Todo';
  final tCompleted = false;
  final tUserId = 1;
  final tTodoDetailsEntity = TodoDetailsEntity(
    todo: tTodo,
    completed: tCompleted,
    userId: tUserId,
  );
  final tParams = CreateTodoParams(
    todo: tTodo,
    completed: tCompleted,
    userId: tUserId,
  );

  test('should return TodoDetailsEntity when the call to TodoRepository is successful', () async {
    // arrange
    when(mockTodoRepository.createTodo(any))
        .thenAnswer((_) async => Right(tTodoDetailsEntity));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.createTodo(tTodoDetailsEntity));
    expect(result, Right(tTodoDetailsEntity));
  });

  test('should return ApiError when the call to TodoRepository is unsuccessful', () async {
    // arrange
    final tError = ApiError(message: 'Error creating todo', errorType: 'CREATE_TODO_ERROR');
    when(mockTodoRepository.createTodo(any))
        .thenAnswer((_) async => Left(tError));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.createTodo(tTodoDetailsEntity));
    expect(result, Left(tError));
  });
}