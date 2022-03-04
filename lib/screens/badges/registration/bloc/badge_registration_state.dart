part of 'badge_registration_bloc.dart';

enum BadgeRegistrationStateStatus { initial, loading, success, failure }

@immutable
class BadgeRegistrationState extends Equatable {
  final BadgeRegistrationStateStatus badgeRegistrationStatus;

//TODO: TILFØJ LEDER
  final Group group;
  final List<Group> groups;
  final String failureMessage;

  const BadgeRegistrationState(
      {this.badgeRegistrationStatus = BadgeRegistrationStateStatus.initial,
      this.group = Group.empty,
      this.groups = const <Group>[],
      this.failureMessage = ''});

  BadgeRegistrationState copyWith(
      {BadgeRegistrationStateStatus? badgeRegistrationStatus,
      Group? group,
      List<Group>? groups,
      String? failureMessage}) {
    return BadgeRegistrationState(
        badgeRegistrationStatus: badgeRegistrationStatus ?? this.badgeRegistrationStatus,
        group: group ?? this.group,
        groups: groups ?? this.groups,
        failureMessage: failureMessage ?? this.failureMessage);
  }

  @override
  List<Object> get props => [
        badgeRegistrationStatus,
        group.name,
        groups,
      ];
}

/*abstract class BadgeRegistrationState extends Equatable {
  const BadgeRegistrationState();

  @override
  List<Object> get props => [];
}

class BadgeRegistrationInitial extends BadgeRegistrationState {}
*/
