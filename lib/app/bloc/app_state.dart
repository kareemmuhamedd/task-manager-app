part of 'app_bloc.dart';

/// The status of the application. Used to determine which page to show when
/// the application is started.

enum AppStatus {
  /// The application is in an initial state. Route resolution is deferred.
  initial,

  /// The user is authenticated. Show `MainPage`.
  authenticated,

  /// The user is not authenticated. Show `AuthPage`.
  unauthenticated,

  /// The user needs to complete onboarding. Show `OnboardingPage`.
  onboardingRequired,
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
  });

  final AppStatus status;

  const AppState.initial() : this(status: AppStatus.initial);

  const AppState.onboardingRequired()
      : this(status: AppStatus.onboardingRequired);

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  const AppState.authenticated() : this(status: AppStatus.authenticated);

  AppState copyWith({
    AppStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
