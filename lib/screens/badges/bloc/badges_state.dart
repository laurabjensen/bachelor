part of 'badges_bloc.dart';

abstract class BadgesState extends Equatable {
  const BadgesState();
  
  @override
  List<Object> get props => [];
}

class BadgesInitial extends BadgesState {}
