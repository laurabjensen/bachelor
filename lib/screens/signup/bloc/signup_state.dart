part of 'signup_bloc.dart';

enum SignupStateStatus { initial, loading, success, failure }

@immutable
class SignupState extends Equatable {
  final SignupStateStatus signupStatus;
  final String name;
  final String username;
  final String password;
  final String passwordConfirm;
  final Group group;
  final Rank rank;
  final List<Group> groups;
  final List<Rank> ranks;

  const SignupState(
      {this.signupStatus = SignupStateStatus.initial,
      this.name = '',
      this.username = '',
      this.password = '',
      this.passwordConfirm = '',
      this.group = Group.empty,
      this.rank = Rank.empty,
      this.groups = const <Group>[],
      this.ranks = const <Rank>[]});

  SignupState copyWith(
      {SignupStateStatus? signupStatus,
      String? name,
      String? username,
      String? password,
      String? passwordConfirm,
      Group? group,
      Rank? rank,
      List<Group>? groups,
      List<Rank>? ranks}) {
    return SignupState(
        signupStatus: signupStatus ?? this.signupStatus,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        groups: groups ?? this.groups,
        ranks: ranks ?? this.ranks);
  }

  @override
  List<Object> get props => [signupStatus, group.name, rank.title, groups, ranks];
}
