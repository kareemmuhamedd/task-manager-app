import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:management_tasks_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:management_tasks_app/features/auth/data/models/profile_model.dart';
import 'package:management_tasks_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:management_tasks_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_local_data_source.dart';
import 'package:management_tasks_app/features/todos/data/data_sources/todo_remote_data_source.dart';
import 'package:management_tasks_app/features/todos/data/models/todo_model.dart';
import 'package:management_tasks_app/features/todos/domain/usecases/get_pagination_todos_usecase.dart';
import 'package:management_tasks_app/shared/services/hive_services.dart';

import '../../../../shared/networking/connection_checker.dart';
import '../../../../shared/networking/dio_factory.dart';
import '../../features/todos/data/repositories/todo_repository_impl.dart';
import '../../features/todos/domain/repositories/todo_repository.dart';
import '../../features/todos/domain/usecases/create_todo_usecase.dart';
import '../../features/todos/domain/usecases/delete_todo_usecase.dart';
import '../../features/todos/domain/usecases/get_random_todo_usecase.dart';
import '../../features/todos/domain/usecases/get_todo_by_id_usecase.dart';
import '../../features/todos/domain/usecases/get_todos_usecase.dart';
import '../../features/todos/domain/usecases/get_user_todos_usecase.dart';
import '../../features/todos/domain/usecases/update_todo_usecase.dart';
import '../../features/todos/presentation/bloc/todos_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  /// Dio & ApiService
  Dio dio = DioFactory.getDio();
  serviceLocator.registerLazySingleton<Dio>(() => dio);

  /// Internet Connection
  serviceLocator.registerFactory<InternetConnection>(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator<InternetConnection>(),
    ),
  );

  /// Hive Database Initialization
  await HiveService.init();

  /// CORE DEPENDENCIES REGISTRATION STARTS HERE
  await _initAuthRegistration();
  await _initTodosRegistration();
  // _initHomeRegistration();
  // _initDeleteTaskRegistration();
  // _initCreateTaskRegistration();
  // _initProfileRegistration();
  // _initUpdateTaskRegistration();
  // _initTaskDetailsRegistration();
}

Future<void> _initAuthRegistration() async {
  /// Hive Database Initialization for Auth
  final profileBox = await Hive.openBox<ProfileModel>('profile');

  /// Register AuthRemoteDataSource of Auth
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
    ),
  );

  serviceLocator.registerFactory<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(profileBox),
  );

  /// Register AuthRepository of Auth
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
      profileLocalDataSource: serviceLocator<ProfileLocalDataSource>(),
      connectionChecker: serviceLocator<ConnectionChecker>(),
    ),
  );

  /// Register UseCases of Auth
  serviceLocator.registerFactory<LoginUseCase>(
    () => LoginUseCase(
      authRepository: serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      authRepository: serviceLocator<AuthRepository>(),
    ),
  );
}

Future<void> _initTodosRegistration() async {
  /// Hive Database Initialization for Auth
  final todosBox = await Hive.openBox<TodoModel>('todos');

  /// Register TodosRemoteDataSource of Todos
  serviceLocator.registerFactory<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
    ),
  );

  /// Register TodosLocalDataSource of Todos
  serviceLocator.registerFactory<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(todosBox));

  /// Register TodoRepository of Todos
  serviceLocator.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      todoRemoteDataSource: serviceLocator<TodoRemoteDataSource>(),
      todoLocalDataSource: serviceLocator<TodoLocalDataSource>(),
      connectionChecker: serviceLocator<ConnectionChecker>(),
    ),
  );

  /// Register UseCases of Todos

  serviceLocator.registerFactory<GetPaginationTodosUseCase>(
    () => GetPaginationTodosUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<CreateTodoUseCase>(
    () => CreateTodoUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<DeleteTodoUseCase>(
    () => DeleteTodoUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<GetUserTodosUseCase>(
    () => GetUserTodosUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<GetRandomTodoUseCase>(
    () => GetRandomTodoUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<GetTodoByIdUseCase>(
    () => GetTodoByIdUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );
  serviceLocator.registerFactory<GetTodosUseCase>(
    () => GetTodosUseCase(
      todoRepository: serviceLocator<TodoRepository>(),
    ),
  );

  /// Register Blocs of Todos
  serviceLocator.registerLazySingleton(
    () => TodosBloc(
      getPaginationTodosUseCase: serviceLocator<GetPaginationTodosUseCase>(),
      createTodoUseCase: serviceLocator<CreateTodoUseCase>(),
      deleteTodoUseCase: serviceLocator<DeleteTodoUseCase>(),
      updateTodoUseCase: serviceLocator<UpdateTodoUseCase>(),
      getUserTodosUseCase: serviceLocator<GetUserTodosUseCase>(),
      getRandomTodoUseCase: serviceLocator<GetRandomTodoUseCase>(),
      getTodosByUserIdUseCase: serviceLocator<GetTodoByIdUseCase>(),
      getTodosUseCase: serviceLocator<GetTodosUseCase>(),
    ),
  );
}
