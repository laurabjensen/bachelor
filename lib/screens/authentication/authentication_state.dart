part of 'authentication_bloc.dart';

enum AuthenticationStateStatus { uninitialized, unauthenticated, authenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStateStatus status;
  final User? user;

  const AuthenticationState({this.status = AuthenticationStateStatus.uninitialized, this.user});

  AuthenticationState copyWith({AuthenticationStateStatus? status, User? user}) {
    return AuthenticationState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object> get props => [status];
}
