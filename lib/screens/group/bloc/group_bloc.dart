import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  //GroupBloc() : super(GroupInitial());
  final UserProfile userProfile;
  final userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  GroupBloc({required this.userProfile}) : super(GroupState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    /*  on<ApproveBadge>((event, emit) => _approveBadge(event.badgeRegistration, emit));
    on<DenyBadge>((event, emit) => _denyBadge(event.badgeRegistration, emit));
*/
    add(LoadFromFirebase());
    emit(state.copyWith(loadStatus: GroupLoadStatus.loaded));
  }

  Future<List<UserProfile>> loadList() async {
    return await userProfileRepository.getGroupUsersFromGroup(userProfile.group);
    // return await badgeRegistrationRepository.getBadgeRegistrationForLeader(userProfile);
  }

  Future<void> _loadFromFirebase(Emitter<GroupState> emit) async {
    var groupMembers = await loadList();
    emit(state.copyWith(loadStatus: GroupLoadStatus.loaded, groupMembers: groupMembers));
  }
}
