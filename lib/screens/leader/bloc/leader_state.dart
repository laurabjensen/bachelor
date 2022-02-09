part of 'leader_bloc.dart';

abstract class LeaderState extends Equatable {
  const LeaderState();
  
  @override
  List<Object> get props => [];
}

class LeaderInitial extends LeaderState {}
