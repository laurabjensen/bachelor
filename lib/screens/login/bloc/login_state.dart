part of 'login_bloc.dart';

enum LoginStateStatus { initial, loading, success, failure }

@immutable
class LoginState extends Equatable {
  final LoginStateStatus loginStateStatus;
  final String email;
  final String password;
  final String failureMessage;

  const LoginState(
      {this.loginStateStatus = LoginStateStatus.initial,
      this.email = '',
      this.password = '',
      this.failureMessage = ''});

  LoginState copyWith({
    LoginStateStatus? loginStateStatus,
    String? email,
    String? password,
    String? failureMessage,
  }) {
    return LoginState(
        loginStateStatus: loginStateStatus ?? this.loginStateStatus,
        email: email ?? this.email,
        password: password ?? this.password,
        failureMessage: failureMessage ?? this.failureMessage);
  }

  @override
  List<Object> get props => [loginStateStatus, email, password];
}
