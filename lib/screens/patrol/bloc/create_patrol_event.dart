part of 'create_patrol_bloc.dart';

abstract class CreatePatrolEvent extends Equatable {
  const CreatePatrolEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends CreatePatrolEvent {
  const StreamStarted();
}

class LoadUserProfiles extends CreatePatrolEvent {
  const LoadUserProfiles();
}

//TODO! DO we need this?
class UpdateFailure extends CreatePatrolEvent {
  final String failureMessage;

  const UpdateFailure(this.failureMessage);
}

class ToggleSelectedUserProfile extends CreatePatrolEvent {
  final UserProfile userProfile;

  const ToggleSelectedUserProfile(this.userProfile);
}

class CreatePatrol extends CreatePatrolEvent {
  final String name;
  final List<UserProfile> selectedUserProfiles;

  const CreatePatrol(this.name, this.selectedUserProfiles);
}

class UpdatePatrol extends CreatePatrolEvent {
  final String name;
  final Patrol patrol;

  const UpdatePatrol(this.name, this.patrol);
}

class DeletePatrol extends CreatePatrolEvent {
  final Patrol patrol;

  const DeletePatrol(this.patrol);
}
