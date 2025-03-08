// File: test/features/todos/data/todo_remote_data_source_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_details_model.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_model.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_remote_data_source.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';
import 'package:management_tasks_app/shared/networking/api_constants.dart';

import '../../../utilities/json_reader.dart';
import '../../../utilities/mocks/mocks.mocks.dart';

void main() {
  late final Dio mockDio;
  late final TodoRemoteDataSourceImpl mockTodoRemoteDataSourceImpl;
  late final TodoDetailsModel mockTodoDetailsModel;
  late final TodoModel mockTodoModel;
  late final dynamic todoDetailsJson;
  late final dynamic todoJson;

  setUpAll(() {
    mockDio = MockDio();
    mockTodoRemoteDataSourceImpl = TodoRemoteDataSourceImpl(dio: mockDio);
    todoDetailsJson = jsonReader('todo_details_fake_data.json');
    todoJson = jsonReader('todo_fake_data.json');
    mockTodoDetailsModel = TodoDetailsModel.fromJson(todoDetailsJson as Map<String, dynamic>);
    mockTodoModel = TodoModel.fromJson(todoJson as Map<String, dynamic>);
  });

  group('createTodo', () {
    late final Response<dynamic> response;

    setUpAll(() {
      response = Response<dynamic>(
        data: todoDetailsJson,
        requestOptions: RequestOptions(
          path: '${ApiConstants.baseUrl}/todos/add',
        ),
      );
    });

    test('this test should return a todo details model when the call of todo remote data source is success', () async {
      when(mockDio.post(
        '${ApiConstants.baseUrl}/todos/add',
        data: mockTodoDetailsModel.toJson(),
      )).thenAnswer((_) async => response);

      final result = await mockTodoRemoteDataSourceImpl.createTodo(
        mockTodoDetailsModel,
      );

      expect(result, isA<TodoDetailsModel>());
      expect(result, equals(mockTodoDetailsModel));
    });

    test('this test should throw an error when the call of todo remote data source fails', () async {
      when(mockDio.post(
        '${ApiConstants.baseUrl}/todos/add',
        data: mockTodoDetailsModel.toJson(),
      )).thenThrow(DioError(requestOptions: RequestOptions(path: '${ApiConstants.baseUrl}/todos/add')));

      expect(
            () async => await mockTodoRemoteDataSourceImpl.createTodo(
          mockTodoDetailsModel,
        ),
        throwsA(isA<ApiError>()),
      );
    });
  });

  group('deleteTodoById', () {
    late final Response<dynamic> response;

    setUpAll(() {
      response = Response<dynamic>(
        data: todoDetailsJson,
        requestOptions: RequestOptions(
          path: '${ApiConstants.baseUrl}/todos/1',
        ),
      );
    });

    test('this test should return a todo details model when the call of todo remote data source is success', () async {
      when(mockDio.delete('${ApiConstants.baseUrl}/todos/1')).thenAnswer((_) async => response);

      final result = await mockTodoRemoteDataSourceImpl.deleteTodoById(1);

      expect(result, isA<TodoDetailsModel>());
      expect(result, equals(mockTodoDetailsModel));
    });

    test('this test should throw an error when the call of todo remote data source fails', () async {
      when(mockDio.delete('${ApiConstants.baseUrl}/todos/1')).thenThrow(DioError(requestOptions: RequestOptions(path: '${ApiConstants.baseUrl}/todos/1')));

      expect(
            () async => await mockTodoRemoteDataSourceImpl.deleteTodoById(1),
        throwsA(isA<ApiError>()),
      );
    });
  });

  // Add similar tests for other methods like updateTodo, getTodos, getTodoById, getRandomTodo, getPaginationTodos, getUserTodos
}