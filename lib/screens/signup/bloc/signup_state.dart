part of 'signup_bloc.dart';

enum SignupStateStatus { initial, loading, success, failure }

@immutable
class SignupState extends Equatable {
  final SignupStateStatus signupStatus;
  final String name;
  final String password;
  final String group;
  final List<String> groups;
  // TODO: final List<String> ranks;

  const SignupState({
    this.signupStatus = SignupStateStatus.initial,
    this.name = '',
    this.password = '',
    this.group = '',
    this.groups = const <String>[],
    //TODO: this.ranks = const <String>[]
  });

  SignupState copyWith({
    SignupStateStatus? signupStatus,
    String? name,
    String? password,
    String? group,
    List<String>? groups,
    /*List<String>? groups*/
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      name: name ?? this.name,
      password: password ?? this.password,
      group: group ?? this.group,
      groups: groups ?? this.groups,
      //ranks: ranks ?? this.ranks
    );
  }

  @override
  List<Object> get props => [signupStatus, name, password];
}
