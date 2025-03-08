import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_tasks_app/app/view/app_view.dart';
import '../../shared/utilities/local_storage/secure_storage_service.dart';
import '../bloc/app_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<AppState> _initialStateFuture;

  @override
  void initState() {
    super.initState();
    _initialStateFuture = _loadInitialState();
  }

  Future<AppState> _loadInitialState() async {
    final secureStorage = SecureStorageHelper.instance;
    final accessToken = await secureStorage.getString('access_token');
    final refreshToken = await secureStorage.getString('refresh_token');

    if (accessToken != null && refreshToken != null) {
      return const AppState.authenticated();
    } else {
      return const AppState.unauthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppState>(
      future: _initialStateFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocProvider(
          create: (context) {
            final appBloc = AppBloc(initialState: snapshot.data!);
            appBloc.initialize();
            return appBloc;
          },
          child: const AppView(),
        );
      },
    );
  }
}
