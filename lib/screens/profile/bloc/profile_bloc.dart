import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/repositories/posts_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserProfile userProfile;
  final BadgeRegistrationRepository badgeRegistrationRepository =
      GetIt.instance.get<BadgeRegistrationRepository>();
  final PostsRepository postsRepository = GetIt.instance.get<PostsRepository>();
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  ProfileBloc({required this.userProfile}) : super(ProfileState(userProfile: userProfile)) {
    on<StreamStarted>((event, emit) async {
      await emit.onEach<List<UserProfile>>(
          GetIt.instance.get<UserProfileRepository>().getAllUsersStream(), onData: (updatedUser) {
        add(Reload());
      });
    }, transformer: restartable());

    on<SendFriendRequestPressed>(
        (event, emit) => _sendFriendRequestPressed(event.currentUser, emit));
    on<CancelFriendRequest>((event, emit) => _cancelFriendRequest(event.currentUser, emit));
    on<DeleteFriendPressed>((event, emit) => _deleteFriendPressed(event.currentUser, emit));
    on<AcceptFriendRequestPressed>((event, emit) => _acceptFriendRequest(event.currentUser, emit));
    on<RejectFriendRequestPressed>((event, emit) => _rejectFriendRequest(event.currentUser, emit));
    on<LikePostPressed>(
        (event, emit) => _likePostPressed(event.currentUser, event.post, event.isLiked, emit));
    on<Reload>((event, emit) => _reload(emit));

    add(StreamStarted());
  }

  Future<void> _sendFriendRequestPressed(
      UserProfile currentUser, Emitter<ProfileState> emit) async {
    await userProfileRepository.sendFriendRequest(sender: currentUser, receiver: userProfile);
  }

  Future<void> _cancelFriendRequest(UserProfile currentUser, Emitter<ProfileState> emit) async {
    await userProfileRepository.cancelFriendRequest(sender: currentUser, receiver: userProfile);
  }

  Future<void> _acceptFriendRequest(UserProfile currentUser, Emitter<ProfileState> emit) async {
    await userProfileRepository.acceptFriendRequest(sender: userProfile, receiver: currentUser);
  }

  Future<void> _rejectFriendRequest(UserProfile currentUser, Emitter<ProfileState> emit) async {
    await userProfileRepository.cancelFriendRequest(sender: userProfile, receiver: currentUser);
  }

  Future<void> _deleteFriendPressed(UserProfile currentUser, Emitter<ProfileState> emit) async {
    await userProfileRepository.deleteFriend(userProfile: userProfile, currentUser: currentUser);
  }

  Future<void> _likePostPressed(
      UserProfile currentUser, Post post, bool isLiked, Emitter<ProfileState> emit) async {
    await postsRepository.toggleLikesForPost(isLiked, post, currentUser.id);
  }

  Future<void> _reload(Emitter<ProfileState> emit) async {
    var user = await userProfileRepository.getUserprofileFromId(userProfile.id);
    if (user != null) {
      userProfile = user;
    }
    final friends = (await userProfileRepository.getUserprofilesFromList(userProfile.friends))
        .sortedBy((element) => element.name);

    final posts = await postsRepository.getPostsFromUserProfile(userProfile);
    emit(state.copyWith(posts: posts, friends: friends, userProfile: userProfile));
  }
}
