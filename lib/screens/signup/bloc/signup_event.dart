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

class AgeChanged extends SignupEvent {
  final int age;

  const AgeChanged(this.age);
}

class EmailChanged extends SignupEvent {
  final String email;

  const EmailChanged(this.email);
}

class PasswordChanged extends SignupEvent {
  final String password;

  const PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends SignupEvent {
  final String password;

  const ConfirmPasswordChanged(this.password);
}

class GroupChanged extends SignupEvent {
  final String? group;

  const GroupChanged(this.group);
}

class RankChanged extends SignupEvent {
  final Rank? rank;

  const RankChanged(this.rank);
}

class SignupFailure extends SignupEvent {
  final String failureMessage;

  const SignupFailure(this.failureMessage);
}
