part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

/* Når brugeren ændre noget kræver det en event*/

class LoadFromFirebase extends SignupEvent {
  const LoadFromFirebase();
}

class SignupPressed extends SignupEvent {
  const SignupPressed();
}

class NameChanged extends SignupEvent {
  final String name;

  const NameChanged(this.name);
}

class UsernameChanged extends SignupEvent {
  final String name;

  const UsernameChanged(this.name);
}

class PasswordChanged extends SignupEvent {
  final String password;

  const PasswordChanged(this.password);
}

class GroupChanged extends SignupEvent {
  final String? group;

  const GroupChanged(this.group);
}

class RankChanged extends SignupEvent {
  final Rank? rank;

  const RankChanged(this.rank);
}
