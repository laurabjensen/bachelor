import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

import '../../../model/user_profile.dart';
import '../../../repositories/image_repository.dart';
import '../../authentication/authentication_bloc.dart';
import '../../profile/bloc/profile_bloc.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
  final ImageRepository imageRepository = GetIt.instance.get<ImageRepository>();
  bool deleteOldImage = false;
  final AuthenticationBloc authenticationBloc;
  final ProfileBloc profileBloc;

  EditprofileBloc(UserProfile userProfile,
      {required this.authenticationBloc, required this.profileBloc})
      : super(EditprofileState(userprofile: userProfile)) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<GroupChanged>((event, emit) => _groupChanged(event.group, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));
    on<UpdatePressed>((event, emit) => _updatePressed(event.userprofile, emit));
    on<NewImageFile>(((event, emit) => _newImageFile(event.image, emit)));

    add(LoadFromFirebase());
  }

  //Henter userprofile for brugeren der er logget ind
  Future<void> _loadFromFirebase(Emitter<EditprofileState> emit) async {
    final groups = GetIt.instance.get<List<Group>>();
    final ranks = GetIt.instance.get<List<Rank>>();
    emit(state.copyWith(groups: groups, ranks: ranks));
  }

  Future<void> _groupChanged(String? name, Emitter<EditprofileState> emit) async {
    if (name == null || name.isEmpty) {
      emit(state.copyWith(group: Group.empty));
    } else {
      final group = state.groups.firstWhere((element) => element.name == name);
      emit(state.copyWith(group: group));
    }
  }

  Future<void> _rankChanged(Rank? rank, Emitter<EditprofileState> emit) async {
    if (rank == null) {
      emit(state.copyWith(rank: Rank.empty));
    } else {
      emit(state.copyWith(rank: rank));
    }
  }

  Future<void> updateLeaderLists(UserProfile old, UserProfile updated) async {
    // Hvis leder skifter gruppe
    if (old.rank.title == 'Leder' &&
        updated.rank.title == 'Leder' &&
        old.group.id != updated.group.id) {
      await groupRepository.removeLeaderFromGroup(old.group, old.id);
      await groupRepository.addLeaderToGroup(updated.group, updated.id);
    }
    // Hvis man opdateres til at blive leder
    else if (updated.rank.title == 'Leder') {
      await groupRepository.addLeaderToGroup(updated.group, updated.id);
    }
    // Hvis man var leder men ikke er leder længere
    else if (old.rank.title == 'Leder' && updated.rank.title != 'Leder') {
      await groupRepository.removeLeaderFromGroup(old.group, old.id);
    }
  }

  Future<void> _updatePressed(UserProfile userprofile, Emitter<EditprofileState> emit) async {
    emit(state.copyWith(editprofileStatus: EditprofileStateStatus.loading));
    var path;
    if (state.imageFile != null) {
      path = await imageRepository.addFileToStorage(state.imageFile!, userprofile.id);
      debugPrint(path);
    }
    final updatedUserprofile =
        userprofile.copyWith(group: state.group, rank: state.rank, imageUrl: path);
    await updateLeaderLists(userprofile, updatedUserprofile);
    await userProfileRepository.updateUserprofile(updatedUserprofile);
    authenticationBloc.add(UserUpdatedAuthentication(updatedUserprofile));
    profileBloc.add(UserUpdatedProfile(updatedUserprofile));
    emit(state.copyWith(
        editprofileStatus: EditprofileStateStatus.success, userprofile: updatedUserprofile));
  }

  Future<void> _newImageFile(File? image, Emitter<EditprofileState> emit) async {
    if (image != null && image.path.isNotEmpty) {
      return emit(state.copyWith(imageFile: image));
    } /*else if (image == null && state.imageFile != null) {
      return emit(state.copyWith(imageFile: null));
    } else if (image == null && state.imageFile == null) {
      deleteOldImage = true;
      return emit(state.copyWith(imageFile: null));
    }*/
  }
}
