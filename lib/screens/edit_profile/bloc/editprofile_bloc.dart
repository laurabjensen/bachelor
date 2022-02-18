import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/custom_exception.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';

import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();
  final UserProfileRepository userProfileRepository =
      GetIt.instance.get<UserProfileRepository>();

  EditprofileBloc() : super(EditprofileState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<NameChanged>((event, emit) => _nameChanged(event.name, emit));
    on<GroupChanged>((event, emit) => _groupChanged(event.group, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));
    on<UpdatePressed>((event, emit) => _updatePressed(emit));
    on<UpdateFailure>(
        (event, emit) => _updateFailure(event.failureMessage, emit));

    add(LoadFromFirebase());
  }

  //Henter userprofile for brugeren der er logget ind
  Future<void> _loadFromFirebase(Emitter<EditprofileState> emit) async {
    final groups = await groupRepository.getGroups();
    final ranks = await rankRepository.getRanks();
    emit(state.copyWith(groups: groups, ranks: ranks));
  }

  Future<void> _nameChanged(String name, Emitter<EditprofileState> emit) async {
    emit(state.copyWith(name: name));
  }

  Future<void> _groupChanged(
      String? name, Emitter<EditprofileState> emit) async {
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

  Future<void> _updatePressed(Emitter<EditprofileState> emit) async {
    /*emit(state.copyWith(editprofileStatus: EditprofileStateStatus.loading));
    try {
      final user =
          await authenticationRepository.createUserFromEditprofileState(state);
      await authenticationRepository.addUserToFirebaseFromSignupState(
          user, state);
      emit(state.copyWith(editprofileStatus: EditprofileStateStatus.success));
    } on CustomException catch (e) {
      add(UpdateFailure(e.message));
    }*/
  }

  Future<void> _updateFailure(
      String failureMessage, Emitter<EditprofileState> emit) async {
    emit(state.copyWith(
        editprofileStatus: EditprofileStateStatus.failure,
        failureMessage: failureMessage));
    emit(state.copyWith(
        editprofileStatus: EditprofileStateStatus.initial, failureMessage: ''));
  }
}

/*
  @override
  Stream<EditprofileState> mapEventToState(
    EditprofileEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
*/
