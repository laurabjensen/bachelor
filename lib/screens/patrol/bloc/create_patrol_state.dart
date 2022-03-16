part of 'create_patrol_bloc.dart';

enum CreatePatrolStateStatus { initial, loading, success, failure }

@immutable
class CreatePatrolState extends Equatable {
  final CreatePatrolStateStatus createPatrolStatus;
  final Rank? rank;
  final List<Rank> ranks;

  const CreatePatrolState({
    this.createPatrolStatus = CreatePatrolStateStatus.initial,
    this.rank,
    this.ranks = const <Rank>[],
  });

  CreatePatrolState copyWith(
      {CreatePatrolStateStatus? createPatrolStatus,
      Rank? rank,
      List<Rank>? ranks,
      UserProfile? userprofile}) {
    return CreatePatrolState(
      createPatrolStatus: createPatrolStatus ?? this.createPatrolStatus,
      rank: rank ?? this.rank,
      ranks: ranks ?? this.ranks,
    );
  }

  @override
  List<Object> get props => [
        createPatrolStatus,
        rank?.title ?? '',
      ];
}
