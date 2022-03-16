part of 'create_patrol_bloc.dart';

abstract class CreatePatrolEvent extends Equatable {
  const CreatePatrolEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends CreatePatrolEvent {
  const LoadFromFirebase();
}

class RankChanged extends CreatePatrolEvent {
  final Rank? rank;

  const RankChanged(this.rank);
}

//TODO! DO we need this?
class UpdateFailure extends CreatePatrolEvent {
  final String failureMessage;

  const UpdateFailure(this.failureMessage);
}
