part of 'leader_bloc.dart';

abstract class LeaderEvent extends Equatable {
  const LeaderEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends LeaderEvent {
  const LoadFromFirebase();
}

class ApproveBadge extends LeaderEvent {
  final BadgeRegistration badgeRegistration;
  const ApproveBadge(this.badgeRegistration);
}

class DenyBadge extends LeaderEvent {
  final BadgeRegistration badgeRegistration;
  const DenyBadge(this.badgeRegistration);
}
