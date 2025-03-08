import 'package:dio/dio.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_details_model.dart';
import 'package:management_tasks_app/shared/networking/api_constants.dart';

import '../../../../shared/errors/custom_error_handler.dart';
import '../models/todo_model.dart';

abstract interface class TodoRemoteDataSource {
  Future<TodoModel> getTodos();

  Future<TodoModel> getTodoById(int id);

  Future<TodoModel> getRandomTodo();

  Future<TodoModel> getPaginationTodos({
    required int limit,
    required int skip,
  });

  Future<TodoModel> getUserTodos(int userId);

  Future<TodoDetailsModel> createTodo(TodoDetailsModel todo);

  Future<TodoDetailsModel> updateTodo(
    TodoDetailsModel todo,
    int todoId,
  );

  Future<TodoDetailsModel> deleteTodoById(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TodoDetailsModel> createTodo(TodoDetailsModel todo) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/todos/add',
        data: todo.toJson(),
      );
      return TodoDetailsModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoDetailsModel> deleteTodoById(int id) async {
    try {
      final response = await _dio.delete('${ApiConstants.baseUrl}/todos/$id');
      return TodoDetailsModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoDetailsModel> updateTodo(
    TodoDetailsModel todo,
    int todoId,
  ) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.baseUrl}/todos/$todoId',
        data: todo.toJson(),
      );
      return TodoDetailsModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoModel> getPaginationTodos({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/todos?limit=$limit&skip=$skip',
      );
      return TodoModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoModel> getRandomTodo() async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}/todos/random');
      return TodoModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}/todos/$id');
      return TodoModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoModel> getTodos() async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}/todos');
      return TodoModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }

  @override
  Future<TodoModel> getUserTodos(int userId) async {
    try {
      final response =
          await _dio.get('${ApiConstants.baseUrl}/todos/user/$userId');
      return TodoModel.fromJson(response.data);
    } catch (error) {
      final apiError = await CustomErrorHandler.handleError(error);
      throw apiError; // Throw the structured error
    }
  }
}
