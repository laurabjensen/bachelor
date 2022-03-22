part of 'leader_bloc.dart';

enum LeaderLoadStatus { loading, loaded }
enum LeaderBadgeRegistrationStatus { initial, loading, finished }

@immutable
class LeaderState extends Equatable {
  final List<BadgeRegistration> badgeRegistrations;
  final LeaderLoadStatus loadStatus;
  final LeaderBadgeRegistrationStatus registrationStatus;

  const LeaderState(
      {this.badgeRegistrations = const [],
      this.loadStatus = LeaderLoadStatus.loading,
      this.registrationStatus = LeaderBadgeRegistrationStatus.initial});

  LeaderState copyWith(
      {List<BadgeRegistration>? badgeRegistrations,
      LeaderLoadStatus? loadStatus,
      LeaderBadgeRegistrationStatus? registrationStatus}) {
    return LeaderState(
        badgeRegistrations: badgeRegistrations ?? this.badgeRegistrations,
        loadStatus: loadStatus ?? this.loadStatus,
        registrationStatus: registrationStatus ?? this.registrationStatus);
  }

  @override
  List<Object?> get props => [badgeRegistrations, loadStatus, registrationStatus];
}
