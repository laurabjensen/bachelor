part of 'leader_bloc.dart';

abstract class LeaderEvent extends Equatable {
  const LeaderEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends LeaderEvent {
  const LoadFromFirebase();
}
