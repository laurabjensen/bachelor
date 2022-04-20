part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends FriendsEvent {
  const StreamStarted();
}

class Reload extends FriendsEvent {
  const Reload();
}

class LoadFriends extends FriendsEvent {
  const LoadFriends();
}
