part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class StartStream extends PostEvent {
  const StartStream();
}

class Reload extends PostEvent {
  final Post post;
  const Reload(this.post);
}
