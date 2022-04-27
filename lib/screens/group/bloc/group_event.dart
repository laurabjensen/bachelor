part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends GroupEvent {
  const StreamStarted();
}

class UserStreamStarted extends GroupEvent {
  const UserStreamStarted();
}

class GroupStreamStarted extends GroupEvent {
  const GroupStreamStarted();
}

class PatrolStreamStarted extends GroupEvent {
  const PatrolStreamStarted();
}

class LoadFromFirebase extends GroupEvent {
  const LoadFromFirebase();
}
