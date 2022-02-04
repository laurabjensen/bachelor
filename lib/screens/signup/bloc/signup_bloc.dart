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
import 'package:spejder_app/repositories/login_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();
  final AuthenticationRepository authenticationRepository =
      GetIt.instance.get<AuthenticationRepository>();

  SignupBloc() : super(SignupState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<NameChanged>((event, emit) => _nameChanged(event.name, emit));
    on<EmailChanged>((event, emit) => _emailChanged(event.email, emit));
    on<PasswordChanged>((event, emit) => _passwordChanged(event.password, emit));
    on<ConfirmPasswordChanged>((event, emit) => _confirmPasswordChanged(event.password, emit));
    on<GroupChanged>((event, emit) => _groupChanged(event.group, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));
    on<SignupPressed>((event, emit) => _signupPressed(emit));
    on<SignupFailure>((event, emit) => _signupFailure(event.failureMessage, emit));

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

  Future<void> _emailChanged(String email, Emitter<SignupState> emit) async {
    emit(state.copyWith(email: email));
  }

  Future<void> _passwordChanged(String password, Emitter<SignupState> emit) async {
    emit(state.copyWith(password: password));
  }

  Future<void> _confirmPasswordChanged(String password, Emitter<SignupState> emit) async {
    emit(state.copyWith(passwordConfirm: password));
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

  Future<void> _signupPressed(Emitter<SignupState> emit) async {
    emit(state.copyWith(signupStatus: SignupStateStatus.loading));
    try {
      final user = await authenticationRepository.createUserFromSignupState(state);
      await authenticationRepository.addUserToFirebaseFromSignupState(user, state);
      emit(state.copyWith(signupStatus: SignupStateStatus.success));
    } on CustomException catch (e) {
      add(SignupFailure(e.message));
    }
  }

  Future<void> _signupFailure(String failureMessage, Emitter<SignupState> emit) async {
    emit(state.copyWith(signupStatus: SignupStateStatus.failure, failureMessage: failureMessage));
    emit(state.copyWith(signupStatus: SignupStateStatus.initial, failureMessage: ''));
  }
}
