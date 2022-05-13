import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/patrol.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'create_patrol_event.dart';
part 'create_patrol_state.dart';

class CreatePatrolBloc extends Bloc<CreatePatrolEvent, CreatePatrolState> {
  UserProfile userProfile;
  //final Group group;
  final Patrol? patrol;
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();

  CreatePatrolBloc({required this.userProfile, required this.patrol})
      : super(CreatePatrolState(userProfile: userProfile)) {
    on<StreamStarted>((event, emit) async {
      await emit.onEach<UserProfile>(userProfileRepository.getUser(userProfile.id),
          onData: (updatedUserProfile) {
        userProfile = updatedUserProfile;
        add(LoadUserProfiles());
      });
    }, transformer: restartable());

    on<LoadUserProfiles>((event, emit) => _loadUserProfiles(emit));
    on<ToggleSelectedUserProfile>(
        (event, emit) => _toggleSelectedUserProfile(event.userProfile, emit));
    on<CreatePatrol>((event, emit) => _createPatrol(event.name, event.selectedUserProfiles, emit));
    on<UpdatePatrol>((event, emit) => _updatePatrol(event.name, event.patrol, emit));
    on<DeletePatrol>((event, emit) => _deletePatrol(event.patrol, emit));

    add(StreamStarted());
  }

  //Henter userprofile for brugeren der er logget ind

  Future<void> _loadUserProfiles(Emitter<CreatePatrolState> emit) async {
    var user = await userProfileRepository.getUserprofileFromId(userProfile.id);
    if (user != null) {
      userProfile = user;
    }
    final userProfiles = await userProfileRepository.getMembersNotInPatrol(userProfile.group);
    if (patrol != null) {
      return emit(state.copyWith(
          userProfile: userProfile,
          userProfiles: patrol!.members + userProfiles,
          selectedUserProfiles: patrol!.members));
    }
    emit(state.copyWith(userProfiles: userProfiles));
  }

  Future<void> _toggleSelectedUserProfile(
      UserProfile userProfile, Emitter<CreatePatrolState> emit) async {
    if (state.selectedUserProfiles.contains(userProfile)) {
      emit(state.copyWith(
          selectedUserProfiles:
              state.selectedUserProfiles.where((u) => u != userProfile).toList()));
    } else {
      emit(state.copyWith(selectedUserProfiles: state.selectedUserProfiles + [userProfile]));
    }
  }

  Future<void> _createPatrol(
      String name, List<UserProfile> selectedUserProfiles, Emitter<CreatePatrolState> emit) async {
    emit(state.copyWith(createPatrolStatus: CreatePatrolStateStatus.loading));
    final patrol =
        await groupRepository.createPatrol(userProfile.group, name, selectedUserProfiles);
    emit(state.copyWith(
        createPatrolStatus: CreatePatrolStateStatus.success,
        createPatrolStatusMessage: 'Patrulje oprettet'));
  }

  Future<void> _updatePatrol(String name, Patrol patrol, Emitter<CreatePatrolState> emit) async {
    emit(state.copyWith(createPatrolStatus: CreatePatrolStateStatus.loading));
    final newMembers =
        state.selectedUserProfiles.where((element) => !patrol.members.contains(element)).toList();
    final oldMembers =
        patrol.members.where((element) => !state.selectedUserProfiles.contains(element)).toList();
    await groupRepository.updatePatrol(userProfile.group, patrol.copyWith(name: name),
        state.selectedUserProfiles, newMembers, oldMembers);
    emit(state.copyWith(
        createPatrolStatus: CreatePatrolStateStatus.success,
        createPatrolStatusMessage: 'Patrulje opdateret'));
  }

  Future<void> _deletePatrol(Patrol patrol, Emitter<CreatePatrolState> emit) async {
    emit(state.copyWith(createPatrolStatus: CreatePatrolStateStatus.loading));
    await groupRepository.deletePatrol(userProfile.group, patrol);
    emit(state.copyWith(
        createPatrolStatus: CreatePatrolStateStatus.success,
        createPatrolStatusMessage: 'Patrulje slettet'));
  }
}
