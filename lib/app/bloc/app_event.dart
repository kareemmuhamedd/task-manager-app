part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppRedirectAfterLoggedOut extends AppEvent {
  const AppRedirectAfterLoggedOut();
}

final class DetermineAppStateRequested extends AppEvent {
  const DetermineAppStateRequested();
}

final class CompleteOnboarding extends AppEvent {
  const CompleteOnboarding();
}
