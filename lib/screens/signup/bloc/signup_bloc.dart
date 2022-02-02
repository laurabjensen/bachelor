import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();

  SignupBloc() : super(SignupState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<NameChanged>((event, emit) => _nameChanged(event.name, emit));
    on<UsernameChanged>((event, emit) => _usernameChanged(event.name, emit));
    on<PasswordChanged>((event, emit) => _passwordChanged(event.password, emit));
    on<GroupChanged>((event, emit) => _groupChanged(event.group, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));

    add(LoadFromFirebase());
  }

  Future<void> _loadFromFirebase(Emitter<SignupState> emit) async {
    final groups = await groupRepository.getGroups();
    final ranks = await rankRepository.getRanks();
    emit(state.copyWith(groups: groups, ranks: ranks));
  }

  Future<void> _nameChanged(String name, Emitter<SignupState> emit) async {
    emit(state.copyWith(name: name));
  }

  Future<void> _usernameChanged(String name, Emitter<SignupState> emit) async {
    emit(state.copyWith(username: name));
  }

  Future<void> _passwordChanged(String password, Emitter<SignupState> emit) async {
    emit(state.copyWith(password: password));
  }

  Future<void> _groupChanged(String? name, Emitter<SignupState> emit) async {
    if (name == null || name.isEmpty) {
      emit(state.copyWith(group: Group.empty));
    } else {
      final group = state.groups.firstWhere((element) => element.name == name);
      emit(state.copyWith(group: group));
    }
  }

  Future<void> _rankChanged(Rank? rank, Emitter<SignupState> emit) async {
    if (rank == null) {
      emit(state.copyWith(rank: Rank.empty));
    } else {
      emit(state.copyWith(rank: rank));
    }
  }
}
