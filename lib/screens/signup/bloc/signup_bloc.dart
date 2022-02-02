import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<NameChanged>((event, emit) => _nameChanged(event.name, emit));
    on<PasswordChanged>((event, emit) => _passwordChanged(event.password, emit));
    on<GroupChanged>((event, emit) => _groupChanged(event.group, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));

    add(LoadFromFirebase());
  }

  Future<void> _loadFromFirebase(Emitter<SignupState> emit) async {}

  Future<void> _nameChanged(String name, Emitter<SignupState> emit) async {
    emit(state.copyWith(name: name));
  }

  Future<void> _passwordChanged(String password, Emitter<SignupState> emit) async {
    emit(state.copyWith(password: password));
  }

  Future<void> _groupChanged(String group, Emitter<SignupState> emit) async {
    emit(state.copyWith(group: group));
  }

  Future<void> _rankChanged(String rank, Emitter<SignupState> emit) async {
    //emit(state.copyWith(rank: rank));
  }
}
