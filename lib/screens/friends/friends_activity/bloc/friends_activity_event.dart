part of 'friends_activity_bloc.dart';

abstract class FriendsActivityEvent extends Equatable {
  const FriendsActivityEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends FriendsActivityEvent {
  const StreamStarted();
}

class LoadUserprofiles extends FriendsActivityEvent {
  const LoadUserprofiles();
}

class AcceptFriend extends FriendsActivityEvent {
  final UserProfile sender;
  const AcceptFriend(this.sender);
}

class RejectFriend extends FriendsActivityEvent {
  final UserProfile sender;
  const RejectFriend(this.sender);
}
