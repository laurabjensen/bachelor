part of 'badge_registration_bloc.dart';

enum BadgeRegistrationStateStatus { initial, loading, success, failure }

@immutable
class BadgeRegistrationState extends Equatable {
  final BadgeRegistrationStateStatus badgeRegistrationStatus;
  final DateTime? date;
  final UserProfile? leader;
  final String failureMessage;

  const BadgeRegistrationState(
      {this.badgeRegistrationStatus = BadgeRegistrationStateStatus.initial,
      this.date,
      this.leader,
      this.failureMessage = ''});

  BadgeRegistrationState copyWith(
      {BadgeRegistrationStateStatus? badgeRegistrationStatus,
      DateTime? date,
      UserProfile? leader,
      String? failureMessage}) {
    return BadgeRegistrationState(
        badgeRegistrationStatus: badgeRegistrationStatus ?? this.badgeRegistrationStatus,
        date: date ?? this.date,
        leader: leader ?? this.leader,
        failureMessage: failureMessage ?? this.failureMessage);
  }

  @override
  List<Object> get props => [badgeRegistrationStatus, date.toString(), leader?.id ?? ''];
}
