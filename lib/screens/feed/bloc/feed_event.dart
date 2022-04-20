part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class StreamStarted extends FeedEvent {
  const StreamStarted();
}

class LoadInitialFeed extends FeedEvent {
  const LoadInitialFeed();
}

class LoadFeed extends FeedEvent {
  const LoadFeed();
}

class LikeToggled extends FeedEvent {
  final Post post;
  final bool isLiked;

  const LikeToggled(this.post, this.isLiked);
}
