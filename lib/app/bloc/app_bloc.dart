import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../shared/utilities/local_storage/secure_storage_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SecureStorageHelper _secureStorage = SecureStorageHelper.instance;

  AppBloc({required AppState initialState}) : super(initialState) {
    on<DetermineAppStateRequested>(_onDetermineAppStateRequested);
    on<AppRedirectAfterLoggedOut>(_onAppRedirectAfterLoggedOut);

    add(const DetermineAppStateRequested());
  }

  Future<void> initialize() async {
    add(const DetermineAppStateRequested());
  }

  /// Handles the [DetermineAppStateRequested] event.
  Future<void> _onDetermineAppStateRequested(
      DetermineAppStateRequested event,
      Emitter<AppState> emit,
      ) async {
    final accessToken = await _secureStorage.getString('access_token');
    final refreshToken = await _secureStorage.getString('refresh_token');

    if (accessToken != null && refreshToken != null) {
      emit(state.copyWith(status: AppStatus.authenticated));
    } else {
      emit(state.copyWith(status: AppStatus.unauthenticated));
    }
  }

  /// Handles the [AppRedirectAfterLoggedOut] event.
  Future<void> _onAppRedirectAfterLoggedOut(
      AppRedirectAfterLoggedOut event,
      Emitter<AppState> emit,
      ) async {
    await _secureStorage.remove('access_token');
    await _secureStorage.remove('refresh_token');

    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
