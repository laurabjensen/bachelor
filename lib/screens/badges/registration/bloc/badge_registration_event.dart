part of 'badge_registration_bloc.dart';

abstract class BadgeRegistrationEvent extends Equatable {
  const BadgeRegistrationEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends BadgeRegistrationEvent {
  const LoadFromFirebase();
}

class DateChanged extends BadgeRegistrationEvent {
  final DateTime date;

  const DateChanged(this.date);
}

class LeaderChanged extends BadgeRegistrationEvent {
  final UserProfile? leader;

  const LeaderChanged(this.leader);
}

class SendRegistrationPressed extends BadgeRegistrationEvent {
  final BadgeSpecific badgeSpecific;
  final String description;
  const SendRegistrationPressed({required this.badgeSpecific, required this.description});
}
