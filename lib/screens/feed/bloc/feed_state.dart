part of 'feed_bloc.dart';

class FeedState extends Equatable {
  final List<Post> posts;

  const FeedState({this.posts = const []});

  FeedState copyWith({
    List<Post>? posts,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];
}
