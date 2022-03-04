part of 'badge_registration_bloc.dart';

abstract class BadgeRegistrationEvent extends Equatable {
  const BadgeRegistrationEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends BadgeRegistrationEvent {
  const LoadFromFirebase();
}

//TODO: SKAL MULIGVIS SLETTES
class GroupChanged extends BadgeRegistrationEvent {
  final String? group;

  const GroupChanged(this.group);
}
