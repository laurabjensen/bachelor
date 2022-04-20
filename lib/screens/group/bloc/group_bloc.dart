import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  //GroupBloc() : super(GroupInitial());
  UserProfile userProfile;
  final userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  GroupBloc({required this.userProfile}) : super(GroupState(userProfile: userProfile)) {
    on<StreamStarted>((event, emit) async {
      await emit
          .onEach<UserProfile>(GetIt.instance.get<UserProfileRepository>().getUser(userProfile.id),
              onData: (updatedUser) {
        userProfile = updatedUser;
        add(LoadFromFirebase());
      });
    }, transformer: restartable());

    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    /*  on<ApproveBadge>((event, emit) => _approveBadge(event.badgeRegistration, emit));
    on<DenyBadge>((event, emit) => _denyBadge(event.badgeRegistration, emit));
*/
    add(StreamStarted());
  }

  Future<List<UserProfile>> loadList() async {
    return await userProfileRepository.getGroupUsersFromGroup(userProfile.group);
    // return await badgeRegistrationRepository.getBadgeRegistrationForLeader(userProfile);
  }

  Future<void> _loadFromFirebase(Emitter<GroupState> emit) async {
    userProfile = await userProfileRepository.getUserprofileFromId(userProfile.id);
    var groupMembers = await loadList();
    emit(state.copyWith(
        loadStatus: GroupLoadStatus.loaded, groupMembers: groupMembers, userProfile: userProfile));
  }
}
