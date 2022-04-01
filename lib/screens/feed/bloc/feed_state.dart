part of 'feed_bloc.dart';

enum FeedStateLoadingStatus { loading, loaded }

class FeedState extends Equatable {
  final FeedStateLoadingStatus status;
  final List<Post> posts;

  const FeedState({this.status = FeedStateLoadingStatus.loading, this.posts = const []});

  FeedState copyWith({
    FeedStateLoadingStatus? status,
    List<Post>? posts,
  }) {
    return FeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [status, posts.length];
}
