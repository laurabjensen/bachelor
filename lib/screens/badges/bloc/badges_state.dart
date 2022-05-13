part of 'badges_bloc.dart';

enum BadgesStateStatus { loading, loaded }

class BadgesState extends Equatable {
  final BadgesStateStatus badgesStatus;
  final List<Badge> allChallengeBadges;
  final List<Badge> allEngagementBadges;
  final List<Badge> allJubileeBadges;
  final List<BadgeRegistration> userChallengeBadges;
  final List<BadgeRegistration> userEngagementBadges;
  final List<BadgeRegistration> userJubileeBadges;
  final List<BadgeRegistration> approvedBadges;
  final List<BadgeRegistration> registrations;
  final bool isEditing;
  final List<UserProfile> peopleForBadgeSpecific;

  const BadgesState(
      {this.allChallengeBadges = const [],
      this.allEngagementBadges = const [],
      this.allJubileeBadges = const [],
      this.badgesStatus = BadgesStateStatus.loading,
      this.userChallengeBadges = const [],
      this.userEngagementBadges = const [],
      this.userJubileeBadges = const [],
      this.approvedBadges = const [],
      this.registrations = const [],
      this.isEditing = false,
      this.peopleForBadgeSpecific = const []});

  @override
  List<Object> get props => [
        badgesStatus,
        allChallengeBadges.length + allEngagementBadges.length + allJubileeBadges.length,
        userChallengeBadges.length + userEngagementBadges.length + userJubileeBadges.length,
        approvedBadges.length,
        registrations.length,
        isEditing,
        peopleForBadgeSpecific
      ];

  BadgesState copyWith(
      {BadgesStateStatus? badgesStatus,
      List<Badge>? allChallengeBadges,
      List<Badge>? allEngagementBadges,
      List<Badge>? allJubileeBadges,
      List<BadgeRegistration>? userChallengeBadges,
      List<BadgeRegistration>? userEngagementBadges,
      List<BadgeRegistration>? userJubileeBadges,
      List<BadgeRegistration>? approvedBadges,
      List<BadgeRegistration>? registrations,
      bool? isEditing,
      List<UserProfile>? peopleForBadgeSpecific}) {
    return BadgesState(
        badgesStatus: badgesStatus ?? this.badgesStatus,
        allChallengeBadges: allChallengeBadges ?? this.allChallengeBadges,
        allEngagementBadges: allEngagementBadges ?? this.allEngagementBadges,
        allJubileeBadges: allJubileeBadges ?? this.allJubileeBadges,
        userChallengeBadges: userChallengeBadges ?? this.userChallengeBadges,
        userEngagementBadges: userEngagementBadges ?? this.userEngagementBadges,
        userJubileeBadges: userJubileeBadges ?? this.userJubileeBadges,
        approvedBadges: approvedBadges ?? this.approvedBadges,
        registrations: registrations ?? this.registrations,
        isEditing: isEditing ?? this.isEditing,
        peopleForBadgeSpecific: peopleForBadgeSpecific ?? this.peopleForBadgeSpecific);
  }
}
