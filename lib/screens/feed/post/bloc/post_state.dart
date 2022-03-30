part of 'post_bloc.dart';

class PostState extends Equatable {
  final Post post;
  const PostState({required this.post});

  PostState copyWith({
    Post? post,
  }) {
    return PostState(
      post: post ?? this.post,
    );
  }

  @override
  List<Object> get props => [post];
}
