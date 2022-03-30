part of 'feed_bloc.dart';

class FeedState extends Equatable {
  final List<BadgeRegistration> approvedBadges;

  const FeedState({this.approvedBadges = const []});

  FeedState copyWith({
    List<BadgeRegistration>? approvedBadges,
  }) {
    return FeedState(
      approvedBadges: approvedBadges ?? this.approvedBadges,
    );
  }

  @override
  List<Object> get props => [approvedBadges];
}
