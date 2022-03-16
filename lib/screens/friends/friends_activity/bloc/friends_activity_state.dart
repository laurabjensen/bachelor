part of 'friends_activity_bloc.dart';

abstract class FriendsActivityState extends Equatable {
  const FriendsActivityState();
  
  @override
  List<Object> get props => [];
}

class FriendsActivityInitial extends FriendsActivityState {}
