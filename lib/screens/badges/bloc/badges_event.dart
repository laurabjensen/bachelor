part of 'badges_bloc.dart';

abstract class BadgesEvent extends Equatable {
  const BadgesEvent();

  @override
  List<Object> get props => [];
}

class LoadAllBadges extends BadgesEvent {
  const LoadAllBadges();
}

class LoadUserBadges extends BadgesEvent {
  const LoadUserBadges();
}
