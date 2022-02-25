part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  const AppStarted();
}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}

class UpdateState extends AuthenticationEvent {
  const UpdateState();
}

class UserUpdatedAuthentication extends AuthenticationEvent {
  final UserProfile userProfile;

  const UserUpdatedAuthentication(this.userProfile);
}
