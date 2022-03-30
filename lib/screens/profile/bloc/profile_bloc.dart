import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/repositories/posts_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

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
      await emit.onEach<UserProfile>(
        GetIt.instance.get<UserProfileRepository>().getUser(userProfile.id),
        onData: (updatedUser) => add(Reload(updatedUser)),
      );
    }, transformer: restartable());

    on<Reload>((event, emit) => _reload(event.userProfile, emit));

    add(StreamStarted());
  }

  Future<void> _reload(UserProfile user, Emitter<ProfileState> emit) async {
    userProfile = await userProfileRepository.getUserprofileFromId(user.id);
    final friends = await userProfileRepository.getFriendUserProfilesForUser(userProfile.friends);
    final posts = await postsRepository.getPostsFromUserProfile(userProfile);
    emit(state.copyWith(posts: posts, friends: friends, userProfile: userProfile));
  }
}
