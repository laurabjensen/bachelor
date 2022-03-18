part of 'leader_bloc.dart';

enum LeaderBadgeRegistrationLoadStatus { loading, loaded }

@immutable
class LeaderState extends Equatable {
  final List<BadgeRegistration> badgeRegistrations;
  final LeaderBadgeRegistrationLoadStatus loadStatus;

  const LeaderState({
    this.badgeRegistrations = const [],
    this.loadStatus = LeaderBadgeRegistrationLoadStatus.loading,
  });

  LeaderState copyWith({
    List<BadgeRegistration>? badgeRegistrations,
    LeaderBadgeRegistrationLoadStatus? loadStatus,
  }) {
    return LeaderState(
      badgeRegistrations: badgeRegistrations ?? this.badgeRegistrations,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [badgeRegistrations, loadStatus];
}
