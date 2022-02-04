part of 'signup_bloc.dart';

enum SignupStateStatus { initial, loading, success, failure }

@immutable
class SignupState extends Equatable {
  final SignupStateStatus signupStatus;
  final String name;
  final String email;
  final String password;
  final String passwordConfirm;
  final Group group;
  final Rank rank;
  final List<Group> groups;
  final List<Rank> ranks;
  final String failureMessage;

  const SignupState(
      {this.signupStatus = SignupStateStatus.initial,
      this.name = '',
      this.email = '',
      this.password = '',
      this.passwordConfirm = '',
      this.group = Group.empty,
      this.rank = Rank.empty,
      this.groups = const <Group>[],
      this.ranks = const <Rank>[],
      this.failureMessage = ''});

  SignupState copyWith(
      {SignupStateStatus? signupStatus,
      String? name,
      String? email,
      String? password,
      String? passwordConfirm,
      Group? group,
      Rank? rank,
      List<Group>? groups,
      List<Rank>? ranks,
      String? failureMessage}) {
    return SignupState(
        signupStatus: signupStatus ?? this.signupStatus,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        groups: groups ?? this.groups,
        ranks: ranks ?? this.ranks,
        failureMessage: failureMessage ?? this.failureMessage);
  }

  @override
  List<Object> get props =>
      [signupStatus, group.name, rank.title, name, email, groups, ranks, password, passwordConfirm];
}
