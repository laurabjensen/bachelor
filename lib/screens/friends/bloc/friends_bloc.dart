import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';

import 'package:equatable/equatable.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:collection/collection.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  UserProfile userProfile;
  final friendsRepository = GetIt.instance.get<UserProfileRepository>();
  final userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  FriendsBloc({required this.userProfile}) : super(FriendsState(userProfile: userProfile)) {
    on<StreamStarted>((event, emit) async {
      await emit.onEach<List<UserProfile>>(userProfileRepository.getAllUsersStream(),
          onData: (updatedList) {
        add(Reload());
      });
    }, transformer: restartable());

    on<Reload>((event, emit) => _reload(emit));

    add(StreamStarted());
  }

  Future<void> _reload(Emitter<FriendsState> emit) async {
    var user = await userProfileRepository.getUserprofileFromId(userProfile.id);
    if (user != null) {
      userProfile = user;
    }

    var allUsers = await userProfileRepository.getAllUsers();
    allUsers.removeWhere((element) => element.id == userProfile.id);

    allUsers.sortedBy((element) => element.name);
    final allUserFriends = (await friendsRepository.getUserprofilesFromList(userProfile.friends))
        .sortedBy((element) => element.name);

    emit(state.copyWith(
      userProfile: userProfile,
      allUsers: allUsers,
      friendsStatus: FriendsStateStatus.loaded,
      allUserFriends: allUserFriends,
    ));
  }
}
