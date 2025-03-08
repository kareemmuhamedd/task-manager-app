import 'package:either_dart/either.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_local_data_source.dart';
import 'package:management_tasks_app/features/todos/data/mappers/todo_mapper.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_details_entity.dart';
import 'package:management_tasks_app/features/todos/domain/entities/todo_entity.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/shared/errors/custom_error_handler.dart';

import '../../../../shared/networking/connection_checker.dart';
import '../data_sources/todo_remote_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required TodoRemoteDataSource todoRemoteDataSource,
    required ConnectionChecker connectionChecker,
    required TodoLocalDataSource todoLocalDataSource,
  })  : _todoRemoteDataSource = todoRemoteDataSource,
        _connectionChecker = connectionChecker,
        _todoLocalDataSource = todoLocalDataSource;
  final TodoRemoteDataSource _todoRemoteDataSource;
  final ConnectionChecker _connectionChecker;
  final TodoLocalDataSource _todoLocalDataSource;

  @override
  Future<Either<ApiError, TodoDetailsEntity>> createTodo(
    TodoDetailsEntity todo,
  ) async {
    try {
      final todoDetailsModel =
          await _todoRemoteDataSource.createTodo(todo.toModel());
      final authEntity = todoDetailsModel.toEntity();
      return Right(authEntity);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoDetailsEntity>> deleteTodoById(int id) async {
    try {
      final todoDetailsModel = await _todoRemoteDataSource.deleteTodoById(id);
      final authEntity = todoDetailsModel.toEntity();
      return Right(authEntity);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoEntity>> getPaginationTodos({
    required int limit,
    required int skip,
  }) async {
    try {
      if (!await _connectionChecker.isConnected) {
        final todoModels = await _todoLocalDataSource.getTodos();
        if (todoModels == null) {
          return Left(ApiError(
            statusCode: 404,
            message: 'No local Todos available',
            errorType: 'NoLocalTodos',
          ));
        }
        final todoEntities = todoModels.toEntity();
        return Right(todoEntities);
      }
      final todoModels = await _todoRemoteDataSource.getPaginationTodos(
          limit: limit, skip: skip);
      final todoEntities = todoModels.toEntity();
      // Save to local storage
      await _todoLocalDataSource.saveTodos(todoModels);
      return Right(todoEntities);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoEntity>> getRandomTodo() async {
    try {
      final todoModel = await _todoRemoteDataSource.getRandomTodo();
      final todoEntity = todoModel.toEntity();
      return Right(todoEntity);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoEntity>> getTodoById(int id) async {
    try {
      final todoModel = await _todoRemoteDataSource.getTodoById(id);
      final todoEntity = todoModel.toEntity();
      return Right(todoEntity);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoDetailsEntity>> updateTodo(
    TodoDetailsEntity todo,
    int todoId,
  ) async {
    try {
      final todoDetailsModel = await _todoRemoteDataSource.updateTodo(
        todo.toModel(),
        todoId,
      );
      final todoDetailsEntity = todoDetailsModel.toEntity();
      return Right(todoDetailsEntity);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoEntity>> getTodos() async {
    try {
      final todoModels = await _todoRemoteDataSource.getTodos();
      final todoEntities = todoModels.toEntity();
      return Right(todoEntities);
    } on ApiError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiError, TodoEntity>> getUserTodos(int userId) async {
    try {
      final todoModels = await _todoRemoteDataSource.getUserTodos(userId);
      final todoEntities = todoModels.toEntity();
      return Right(todoEntities);
    } on ApiError catch (error) {
      return Left(error);
    }
  }
}
