part of 'auth_cubit.dart';

/// [AuthState] submission status, indicating current state of user login
/// process.
enum LogInSubmissionStatus {
  /// [LogInSubmissionStatus.idle] indicates that user has not yet submitted
  /// login form.
  idle,

  /// [LogInSubmissionStatus.loading] indicates that user has submitted
  /// login form and is currently waiting for response from backend.
  loading,

  /// [LogInSubmissionStatus.success] indicates that user has successfully
  /// submitted login form and is currently waiting for response from backend.
  success,

  /// [LogInSubmissionStatus.invalidCredentials] indicates that user has
  /// submitted login form with invalid credentials.
  invalidCredentials,

  /// [LogInSubmissionStatus.userNotFound] indicates that user with provided
  /// credentials was not found in database.
  userNotFound,

  /// [LogInSubmissionStatus.error] indicates that something unexpected happen.
  error;
}

/// {@template login_state}
/// [AuthState] holds all the information related to user login process.
/// It is used to determine current state of user login process.
/// {@endtemplate}
class AuthState {
  /// {@macro login_state}
  const AuthState._({
    required this.status,
    required this.message,
    required this.showPassword,
    required this.userName,
    required this.password,
    this.profile,
  });

  /// Initial login state.
  const AuthState.initial()
      : this._(
          status: LogInSubmissionStatus.idle,
          message: '',
          showPassword: false,
          userName: const Name.pure(),
          password: const Password.pure(),
        );

  final LogInSubmissionStatus status;
  final Name userName;
  final Password password;
  final bool showPassword;
  final String message;
  final ProfileEntity? profile;

  AuthState copyWith({
    LogInSubmissionStatus? status,
    String? message,
    bool? showPassword,
    Name? userName,
    Password? password,
    ProfileEntity? profile,
  }) {
    return AuthState._(
      status: status ?? this.status,
      message: message ?? this.message,
      showPassword: showPassword ?? this.showPassword,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      profile: profile ?? this.profile,
    );
  }
}
