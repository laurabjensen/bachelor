import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/posts_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostsRepository postsRepository = GetIt.instance.get<PostsRepository>();
  final UserProfile userProfile;

  FeedBloc({required this.userProfile}) : super(FeedState()) {
    on<LoadFeed>((event, emit) => _loadFeed(emit));
    on<LikeToggled>((event, emit) => _likeToggled(event.isLiked, event.post, emit));
    add(LoadFeed());
  }

  Future<void> _loadFeed(Emitter<FeedState> emit) async {
    var posts = await postsRepository.getPostsForUserFriends(userProfile);
    emit(state.copyWith(posts: posts));
  }

  Future<void> _likeToggled(bool isLiked, Post post, Emitter<FeedState> emit) async {
    var index = state.posts.indexOf(post);
    post = await postsRepository.toggleLikesForPost(isLiked, post, userProfile.id);
    var posts = state.posts.toList();
    posts.removeAt(index);
    posts.insert(index, post);
    emit(state.copyWith(posts: posts));
  }
}
