import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/repositories/posts_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository postsRepository = GetIt.instance.get<PostsRepository>();
  Post post;
  PostBloc({required this.post}) : super(PostState(post: post)) {
    on<StartStream>((event, emit) async {
      await emit.onEach<Post>(
        postsRepository.getPost(post.id),
        onData: (updatedPost) => add(Reload(updatedPost)),
      );
    }, transformer: restartable());
    on<Reload>((event, emit) => _reload(event.post, emit));
    add(StartStream());
  }

  Future<void> _reload(Post updatedPost, Emitter<PostState> emit) async {
    post = await postsRepository.getPostFromId(updatedPost.id);
    emit(state.copyWith(post: post));
  }
}
