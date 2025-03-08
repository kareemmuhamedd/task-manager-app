import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:management_tasks_app/app/bloc/app_bloc.dart';
import 'package:management_tasks_app/features/auth/presentation/screens/login_screen.dart';
import 'package:management_tasks_app/features/auth/presentation/screens/profile_screen.dart';
import 'package:management_tasks_app/features/todos/presentation/screens/add_todo_screen.dart';
import 'package:management_tasks_app/features/todos/presentation/screens/todos_screen.dart';
import 'package:management_tasks_app/features/todos/presentation/screens/update_todo_screen.dart';

import '../../features/todos/domain/entities/todo_details_entity.dart';

abstract class AppRoutesPaths {
  static const String kAuthScreen = '/auth-screen';
  static const String kTodosScreen = '/todos-screen';
  static const String kAddTodosScreen = '/add-todo-screen';
  static const String kTaskDetailsScreen = '/task-details-screen';
  static const String kCreateTaskScreen = '/create-task-screen';
  static const String kEditTodoScreen = '/update-task-screen';
  static const String kProfileScreen = '/profile-screen';
}

class AppRoutes {
  static GoRouter router(AppBloc appBloc) {
    final notifier = GoRouterNotifier(appBloc);
    return GoRouter(
      initialLocation: AppRoutesPaths.kAuthScreen,
      routes: [
        GoRoute(
          path: AppRoutesPaths.kAuthScreen,
          name: AppRoutesPaths.kAuthScreen,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
            path: AppRoutesPaths.kTodosScreen,
            name: AppRoutesPaths.kTodosScreen,
            builder: (context, state) {
              return const TodosScreen();
            }),
        GoRoute(
          path: AppRoutesPaths.kAddTodosScreen,
          name: AppRoutesPaths.kAddTodosScreen,
          builder: (context, state) {
            return const AddTodoScreen();
          },
        ),
        GoRoute(
          path: AppRoutesPaths.kProfileScreen,
          name: AppRoutesPaths.kProfileScreen,
          builder: (context, state) {
            return const UserProfileScreen();
          },
        ),
        GoRoute(
          path: AppRoutesPaths.kEditTodoScreen,
          name: AppRoutesPaths.kEditTodoScreen,
          builder: (context, state) {
            final todo = state.extra as TodoDetailsEntity;
            return EditTodoScreen(todo: todo);
          },
        ),
      ],
      redirect: (context, state) {
        final appStatus = appBloc.state.status;
        final authenticated = appStatus == AppStatus.authenticated;
        final authenticating =
            state.matchedLocation == AppRoutesPaths.kAuthScreen;
        final isInHome = state.matchedLocation == AppRoutesPaths.kTodosScreen;
        if (isInHome && !authenticated) return AppRoutesPaths.kAuthScreen;
        if (!authenticated) return AppRoutesPaths.kAuthScreen;
        if (authenticated && authenticating) return AppRoutesPaths.kTodosScreen;

        return null;
      },
      refreshListenable: notifier,
    );
  }
}

class GoRouterNotifier extends ChangeNotifier {
  final AppBloc appBloc;
  late final StreamSubscription<AppState> _subscription;

  GoRouterNotifier(this.appBloc) {
    _subscription = appBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
