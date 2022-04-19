part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends ProfileEvent {
  const StreamStarted();
}

class Reload extends ProfileEvent {
  final UserProfile userProfile;

  const Reload(this.userProfile);
}

class SendFriendRequestPressed extends ProfileEvent {
  final UserProfile currentUser;
  const SendFriendRequestPressed(this.currentUser);
}

class CancelFriendRequest extends ProfileEvent {
  final UserProfile currentUser;
  const CancelFriendRequest(this.currentUser);
}

class DeleteFriendPressed extends ProfileEvent {
  final UserProfile currentUser;
  const DeleteFriendPressed(this.currentUser);
}

class AcceptFriendRequestPressed extends ProfileEvent {
  final UserProfile currentUser;
  const AcceptFriendRequestPressed(this.currentUser);
}

class RejectFriendRequestPressed extends ProfileEvent {
  final UserProfile currentUser;
  const RejectFriendRequestPressed(this.currentUser);
}
