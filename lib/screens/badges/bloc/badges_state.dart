part of 'badges_bloc.dart';

enum BadgesStateStatus { loading, loaded }

class BadgesState extends Equatable {
  final BadgesStateStatus badgesStatus;
  final List<Badge> allBadges;

  const BadgesState({this.badgesStatus = BadgesStateStatus.loading, this.allBadges = const []});

  BadgesState copyWith({BadgesStateStatus? badgesStatus, List<Badge>? allBadges}) {
    return BadgesState(
        badgesStatus: badgesStatus ?? this.badgesStatus, allBadges: allBadges ?? this.allBadges);
  }

  @override
  List<Object> get props => [badgesStatus];
}
