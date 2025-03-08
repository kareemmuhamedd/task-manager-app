import 'package:bloc/bloc.dart';
import 'package:management_tasks_app/features/auth/domain/entities/profile_entity.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:management_tasks_app/features/auth/domain/usecases/login_usecase.dart';

import '../../../../shared/utilities/local_storage/secure_storage_service.dart';
import '../../../../shared/usecase/usecase.dart';
import '../../../../shared/utilities/form_fields/formz_valid.dart';
import '../../../../shared/utilities/form_fields/name.dart';
import '../../../../shared/utilities/form_fields/password.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        super(const AuthState.initial());

  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  void changePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void onPasswordChanged(String password) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            password,
          )
        : Password.pure(
            password,
          );
    final newScreenState = state.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void onUserNameChanged(String userName) {
    final previousScreenState = state;
    final previousUserNameState = previousScreenState.userName;
    final shouldValidate = previousUserNameState.invalid;
    final newUserNameState = shouldValidate
        ? Name.dirty(
            userName,
          )
        : Name.pure(
            userName,
          );
    final newScreenState = state.copyWith(
      userName: newUserNameState,
    );
    emit(newScreenState);
  }

  void onSubmitted() async {
    final password = Password.dirty(state.password.value);
    final userName = Name.dirty(state.userName.value);
    final isFormValid = FormzValid([password, userName]).isFormValid;
    final newState = state.copyWith(
      password: password,
      userName: userName,
      status: isFormValid ? LogInSubmissionStatus.loading : null,
    );
    emit(newState);
    if (!isFormValid) return;
    final res = await _loginUseCase.call(UserLoginParams(
      userName: state.userName.value,
      password: state.password.value,
    ));
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: LogInSubmissionStatus.error,
          message: failure.message,
        ));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
      (response) async {
        await SecureStorageHelper.instance
            .setString('access_token', response.accessToken ?? '');
        await SecureStorageHelper.instance
            .setString('refresh_token', response.refreshToken ?? '');
        await SecureStorageHelper.instance
            .setString('user_id', (response.id ?? 1).toString());
        emit(state.copyWith(status: LogInSubmissionStatus.success));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
    );
  }

  void getCurrentUser() async {
    emit(state.copyWith(status: LogInSubmissionStatus.loading));
    final res = await _getCurrentUserUseCase.call(NoParams());
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: LogInSubmissionStatus.error,
          message: failure.message,
        ));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
      (profile) {
        emit(state.copyWith(
          status: LogInSubmissionStatus.success,
          profile: profile,
        ));
        emit(state.copyWith(status: LogInSubmissionStatus.idle));
      },
    );
  }
}
