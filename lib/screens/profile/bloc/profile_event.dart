part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadObjects extends ProfileEvent {
  const LoadObjects();
}

class UserUpdatedProfile extends ProfileEvent {
  final UserProfile userProfile;

  const UserUpdatedProfile(this.userProfile);
}
