part of 'authentication_bloc.dart';

enum AuthenticationStateStatus { uninitialized, unauthenticated, authenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStateStatus status;
  final User? user;
  final UserProfile? userProfile;

  const AuthenticationState(
      {this.status = AuthenticationStateStatus.uninitialized, this.user, this.userProfile});

  AuthenticationState copyWith(
      {AuthenticationStateStatus? status, User? user, UserProfile? userProfile}) {
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user,
        userProfile: userProfile ?? this.userProfile);
  }

  @override
  List<Object> get props => [status, userProfile ?? ''];
}
