part of 'badges_bloc.dart';

enum BadgesStateStatus { loading, loaded }

class BadgesState extends Equatable {
  final BadgesStateStatus badgesStatus;
  final List<Badge> allChallengeBadges;
  final List<Badge> allEngagementBadges;
  final List<Badge> userChallengeBadges;
  final List<Badge> userEngagementBadges;

  const BadgesState({
    this.allChallengeBadges = const [],
    this.allEngagementBadges = const [],
    this.badgesStatus = BadgesStateStatus.loading,
    this.userChallengeBadges = const [],
    this.userEngagementBadges = const [],
  });

  @override
  List<Object> get props => [badgesStatus];

  BadgesState copyWith({
    BadgesStateStatus? badgesStatus,
    List<Badge>? allChallengeBadges,
    List<Badge>? allEngagementBadges,
    List<Badge>? userChallengeBadges,
    List<Badge>? userEngagementBadges,
  }) {
    return BadgesState(
        badgesStatus: badgesStatus ?? this.badgesStatus,
        allChallengeBadges: allChallengeBadges ?? this.allChallengeBadges,
        allEngagementBadges: allEngagementBadges ?? this.allEngagementBadges,
        userChallengeBadges: userChallengeBadges ?? this.userChallengeBadges,
        userEngagementBadges: userEngagementBadges ?? this.userEngagementBadges);
  }
}
