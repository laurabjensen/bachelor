part of 'create_patrulje_bloc.dart';

enum CreatePatruljeStateStatus { initial, loading, success, failure }

@immutable
class CreatePatruljeState extends Equatable {
  final CreatePatruljeStateStatus createPatruljeStatus;
  final Rank? rank;
  final List<Rank> ranks;
  final UserProfile userprofile;

  const CreatePatruljeState(
      {this.createPatruljeStatus = CreatePatruljeStateStatus.initial,
      this.rank,
      this.ranks = const <Rank>[],
      required this.userprofile});

  CreatePatruljeState copyWith(
      {CreatePatruljeStateStatus? createPatruljeStatus,
      Rank? rank,
      List<Rank>? ranks,
      UserProfile? userprofile}) {
    return CreatePatruljeState(
        createPatruljeStatus: createPatruljeStatus ?? this.createPatruljeStatus,
        rank: rank ?? this.rank,
        ranks: ranks ?? this.ranks,
        userprofile: userprofile ?? this.userprofile);
  }

  @override
  List<Object> get props => [
        createPatruljeStatus,
        rank?.title ?? '',
      ];
}
