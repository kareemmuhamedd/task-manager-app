// File: test/features/todos/data/repositories/todo_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_local_data_source.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_remote_data_source.dart';
import 'package:management_tasks_app/features/todos/data/mappers/todo_mapper.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_details_model.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_model.dart';
import 'package:management_tasks_app/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/networking/connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';

import '../../../../utilities/json_reader.dart';
import '../../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockTodoRemoteDataSource;
  late MockConnectionChecker mockConnectionChecker;
  late MockTodoLocalDataSource mockTodoLocalDataSource;

  setUp(() {
    mockTodoRemoteDataSource = MockTodoRemoteDataSource();
    mockConnectionChecker = MockConnectionChecker();
    mockTodoLocalDataSource = MockTodoLocalDataSource();
    repository = TodoRepositoryImpl(
      todoRemoteDataSource: mockTodoRemoteDataSource,
      connectionChecker: mockConnectionChecker,
      todoLocalDataSource: mockTodoLocalDataSource,
    );
  });

  group('createTodo', () {
    final todoJson = jsonReader('todo_details_fake_data.json');
    final tTodoDetailsModel =
        TodoDetailsModel.fromJson(todoJson as Map<String, dynamic>);
    final tTodoDetailsEntity = tTodoDetailsModel.toEntity();

    test(
        'should return TodoDetailsEntity when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTodoRemoteDataSource.createTodo(any))
          .thenAnswer((_) async => tTodoDetailsModel);
      // act
      final result = await repository.createTodo(tTodoDetailsEntity);
      // assert
      verify(mockTodoRemoteDataSource.createTodo(tTodoDetailsEntity.toModel()));
      expect(result, Right(tTodoDetailsEntity));
    });

    test(
        'should return Left<ApiError, dynamic> when the call to remote data source is unsuccessful',
        () async {
      // arrange
      final tError = ApiError(
          message: 'Bad Request', statusCode: 400, errorType: 'HTTP400');
      when(mockTodoRemoteDataSource.createTodo(any)).thenThrow(tError);
      // act
      final result = await repository.createTodo(tTodoDetailsEntity);
      // assert
      verify(mockTodoRemoteDataSource.createTodo(tTodoDetailsEntity.toModel()));
      expect(result, Left<ApiError, TodoEntity>(tError));
    });
  });

  group('deleteTodoById', () {
    final todoJson = jsonReader('todo_details_fake_data.json');
    final tTodoDetailsModel =
        TodoDetailsModel.fromJson(todoJson as Map<String, dynamic>);
    final tTodoDetailsEntity = tTodoDetailsModel.toEntity();

    test(
        'should return TodoDetailsEntity when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTodoRemoteDataSource.deleteTodoById(any))
          .thenAnswer((_) async => tTodoDetailsModel);
      // act
      final result = await repository.deleteTodoById(1);
      // assert
      verify(mockTodoRemoteDataSource.deleteTodoById(1));
      expect(result, Right(tTodoDetailsEntity));
    });

    test(
        'should return Left<ApiError, dynamic> when the call to remote data source is unsuccessful',
        () async {
      // arrange
      final tError = ApiError(
          message: 'Bad Request', statusCode: 400, errorType: 'HTTP400');
      when(mockTodoRemoteDataSource.deleteTodoById(any)).thenThrow(tError);
      // act
      final result = await repository.deleteTodoById(1);
      // assert
      verify(mockTodoRemoteDataSource.deleteTodoById(1));
      expect(result, Left<ApiError, TodoEntity>(tError));
    });
  });

  group('getPaginationTodos', () {
    final todosJson = jsonReader('todo_fake_data.json');
    final tTodoModel = TodoModel.fromJson(todosJson as Map<String, dynamic>);
    final tTodoEntity = tTodoModel.toEntity();

    test(
        'should return TodoEntity when the device is online and the call to remote data source is successful',
        () async {
      // arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockTodoRemoteDataSource.getPaginationTodos(
              limit: anyNamed('limit'), skip: anyNamed('skip')))
          .thenAnswer((_) async => tTodoModel);
      // act
      final result = await repository.getPaginationTodos(limit: 10, skip: 0);
      // assert
      verify(mockConnectionChecker.isConnected);
      verify(mockTodoRemoteDataSource.getPaginationTodos(limit: 10, skip: 0));
      expect(result, Right(tTodoEntity));
    });

    test(
        'should return TodoEntity when the device is offline and the local data source has data',
        () async {
      // arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);
      when(mockTodoLocalDataSource.getTodos())
          .thenAnswer((_) async => Future.value(tTodoModel));
      // act
      final result = await repository.getPaginationTodos(limit: 10, skip: 0);
      // assert
      verify(mockConnectionChecker.isConnected);
      verify(mockTodoLocalDataSource.getTodos());
      expect(result, Right(tTodoEntity));
    });

    // test(
    //     'should return Left<ApiError, dynamic> when the device is offline and the local data source has no data',
    //     () async {
    //   // arrange
    //   when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);
    //   when(mockTodoLocalDataSource.getTodos())
    //       .thenAnswer((_) async => Future.value(null));
    //   // act
    //   final result = await repository.getPaginationTodos(limit: 10, skip: 0);
    //   // assert
    //   verify(mockConnectionChecker.isConnected);
    //   verify(mockTodoLocalDataSource.getTodos());
    //   expect(
    //       result,
    //       Left<ApiError, TodoEntity>(ApiError(
    //           message: 'No local Todos available',
    //           statusCode: 404,
    //           errorType: 'NoLocalTodos')));
    // });

    test(
        'should return Left<ApiError, dynamic> when the call to remote data source is unsuccessful',
        () async {
      // arrange
      final tError = ApiError(
          message: 'Bad Request', statusCode: 400, errorType: 'HTTP400');
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockTodoRemoteDataSource.getPaginationTodos(
              limit: anyNamed('limit'), skip: anyNamed('skip')))
          .thenThrow(tError);
      // act
      final result = await repository.getPaginationTodos(limit: 10, skip: 0);
      // assert
      verify(mockConnectionChecker.isConnected);
      verify(mockTodoRemoteDataSource.getPaginationTodos(limit: 10, skip: 0));
      expect(result, Left<ApiError, TodoEntity>(tError));
    });
  });

  // Add similar tests for other methods in TodoRepositoryImpl
}
