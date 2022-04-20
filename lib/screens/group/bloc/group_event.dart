part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends GroupEvent {
  const StreamStarted();
}

class LoadFromFirebase extends GroupEvent {
  const LoadFromFirebase();
}
