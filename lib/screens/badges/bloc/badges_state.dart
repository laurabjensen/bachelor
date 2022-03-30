part of 'badges_bloc.dart';

enum BadgesStateStatus { loading, loaded }

class BadgesState extends Equatable {
  final BadgesStateStatus badgesStatus;
  final List<Badge> allChallengeBadges;
  final List<Badge> allEngagementBadges;
  final List<BadgeRegistration> userChallengeBadges;
  final List<BadgeRegistration> userEngagementBadges;
  final List<BadgeRegistration> registrations;
  final bool isEditing;

  const BadgesState(
      {this.allChallengeBadges = const [],
      this.allEngagementBadges = const [],
      this.badgesStatus = BadgesStateStatus.loading,
      this.userChallengeBadges = const [],
      this.userEngagementBadges = const [],
      this.registrations = const [],
      this.isEditing = false});

  @override
  List<Object> get props => [
        badgesStatus,
        allChallengeBadges.length + allEngagementBadges.length,
        userChallengeBadges.length + userEngagementBadges.length,
        registrations,
        isEditing
      ];

  BadgesState copyWith(
      {BadgesStateStatus? badgesStatus,
      List<Badge>? allChallengeBadges,
      List<Badge>? allEngagementBadges,
      List<BadgeRegistration>? userChallengeBadges,
      List<BadgeRegistration>? userEngagementBadges,
      List<BadgeRegistration>? registrations,
      bool? isEditing}) {
    return BadgesState(
        badgesStatus: badgesStatus ?? this.badgesStatus,
        allChallengeBadges: allChallengeBadges ?? this.allChallengeBadges,
        allEngagementBadges: allEngagementBadges ?? this.allEngagementBadges,
        userChallengeBadges: userChallengeBadges ?? this.userChallengeBadges,
        userEngagementBadges: userEngagementBadges ?? this.userEngagementBadges,
        registrations: registrations ?? this.registrations,
        isEditing: isEditing ?? this.isEditing);
  }
}
