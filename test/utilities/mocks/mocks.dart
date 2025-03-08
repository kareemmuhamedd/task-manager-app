import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:management_tasks_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_local_data_source.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_remote_data_source.dart';
import 'package:management_tasks_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/create_todo_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/delete_todo_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_pagination_todos_usecase.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:management_tasks_app/shared/networking/connection_checker.dart';
import 'package:management_tasks_app/shared/networking/dio_factory.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DioFactory,
  Dio,
  AuthRemoteDataSource,
  ProfileLocalDataSource,
  TodoRemoteDataSource,
  TodoLocalDataSource,
  AuthRepository,
  TodoRepository,
  GetCurrentUserUseCase,
  LoginUseCase,
  CreateTodoUseCase,
  UpdateTodoUseCase,
  DeleteTodoUseCase,
  GetPaginationTodosUseCase,
  ConnectionChecker,
])
void main() {}
