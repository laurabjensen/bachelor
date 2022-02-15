part of 'badges_bloc.dart';

abstract class BadgesEvent extends Equatable {
  const BadgesEvent();

  @override
  List<Object> get props => [];
}

class LoadBadges extends BadgesEvent {
  const LoadBadges();
}
