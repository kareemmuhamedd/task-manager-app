// File: test/features/todos/domain/usecases/get_pagination_todos_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/data/mappers/todo_mapper.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_model.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_pagination_todos_usecase.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/mocks/mocks.mocks.dart';
import '../../../../utilities/json_reader.dart';

void main() {
  late GetPaginationTodosUseCase useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetPaginationTodosUseCase(todoRepository: mockTodoRepository);
    provideDummy<Either<ApiError, TodoEntity>>(const Right(TodoEntity()));
  });

  final tLimit = 10;
  final tSkip = 0;
  final tTodoModel = TodoModel.fromJson(jsonReader('todo_fake_data.json'));
  final tTodoEntity = tTodoModel.toEntity();
  final tParams = GetPaginationTodosParams(
    limit: tLimit,
    skip: tSkip,
  );

  test('should return TodoEntity when the call to TodoRepository is successful',
      () async {
    // arrange
    when(mockTodoRepository.getPaginationTodos(
      limit: anyNamed('limit'),
      skip: anyNamed('skip'),
    )).thenAnswer((_) async => Right(tTodoEntity));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.getPaginationTodos(
      limit: tLimit,
      skip: tSkip,
    ));
    expect(result, Right(tTodoEntity));
  });

  test('should return ApiError when the call to TodoRepository is unsuccessful',
      () async {
    // arrange
    final tError = ApiError(
        message: 'Error fetching todos',
        errorType: 'GET_PAGINATION_TODOS_ERROR');
    when(mockTodoRepository.getPaginationTodos(
      limit: anyNamed('limit'),
      skip: anyNamed('skip'),
    )).thenAnswer((_) async => Left(tError));
    // act
    final result = await useCase(tParams);
    // assert
    verify(mockTodoRepository.getPaginationTodos(
      limit: tLimit,
      skip: tSkip,
    ));
    expect(result, Left(tError));
  });
}
