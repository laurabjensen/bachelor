import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserProfile userProfile;
  final BadgeRepository badgeRepository = GetIt.instance.get<BadgeRepository>();
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
  ProfileBloc({required this.userProfile}) : super(ProfileState()) {
    on<LoadObjects>((event, emit) => _loadObjects(emit));

    add(LoadObjects());
  }

  Future<void> _loadObjects(Emitter<ProfileState> emit) async {
    emit(state.copyWith(
        badges: await badgeRepository.getBadgesForUser(userProfile.id),
        friends: await userProfileRepository.getFriendsForUser(userProfile.id)));
  }
}
