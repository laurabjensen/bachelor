part of 'badges_bloc.dart';

abstract class BadgesEvent extends Equatable {
  const BadgesEvent();

  @override
  List<Object> get props => [];
}

class UserStreamStarted extends BadgesEvent {
  const UserStreamStarted();
}

class RegistrationStreamStarted extends BadgesEvent {
  const RegistrationStreamStarted();
}

class LoadAllBadges extends BadgesEvent {
  const LoadAllBadges();
}

class LoadUserBadges extends BadgesEvent {
  const LoadUserBadges();
}

class DescriptionUpdated extends BadgesEvent {
  final BadgeRegistration badgeRegistration;
  final String description;

  const DescriptionUpdated(this.badgeRegistration, this.description);
}

class EditingToggled extends BadgesEvent {
  const EditingToggled();
}

class LoadPeopleForBadgeSpecific extends BadgesEvent {
  final BadgeSpecific badgeSpecific;

  const LoadPeopleForBadgeSpecific(this.badgeSpecific);
}

class ClearPeopleForBadgeSpecific extends BadgesEvent {
  const ClearPeopleForBadgeSpecific();
}
