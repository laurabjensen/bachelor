import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:equatable/equatable.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final UserProfile userProfile;
  final friendsRepository = GetIt.instance.get<UserProfileRepository>();

  FriendsBloc({required this.userProfile}) : super(FriendsState()) {
    on<LoadFriends>((event, emit) => _loadFriends(emit));

    add(LoadFriends());
  }

  Future<void> _loadFriends(Emitter<FriendsState> emit) async {
    final allUsers = GetIt.instance.get<List<UserProfile>>();
    final allUserFriends = await friendsRepository
        .getFriendUserProfilesForUser(userProfile.friends);

    emit(state.copyWith(
      friendsStatus: FriendsStateStatus.loaded,
      allUserFriends: allUserFriends,
    ));
  }
}
