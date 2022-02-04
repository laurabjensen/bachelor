part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);
}

class LoginPressed extends LoginEvent {
  const LoginPressed();
}

class LoginFailure extends LoginEvent {
  final String failureMessage;

  const LoginFailure(this.failureMessage);
}
