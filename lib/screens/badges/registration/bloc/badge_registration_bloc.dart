import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/group_repository.dart';

part 'badge_registration_event.dart';
part 'badge_registration_state.dart';

class BadgeRegistrationBloc extends Bloc<BadgeRegistrationEvent, BadgeRegistrationState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();

  BadgeRegistrationBloc() : super(BadgeRegistrationState()) {
    on<DateChanged>((event, emit) => _dateChanged(event.date, emit));
    on<LeaderChanged>((event, emit) => _leaderChanged(event.leader, emit));
    on<SendRegistrationPressed>((event, emit) => _sendRegistrationPressed(emit));
  }

  Future<void> _dateChanged(DateTime date, Emitter<BadgeRegistrationState> emit) async {
    emit(state.copyWith(date: date));
  }

  Future<void> _leaderChanged(UserProfile leader, Emitter<BadgeRegistrationState> emit) async {
    emit(state.copyWith(leader: leader));
  }

  Future<void> _sendRegistrationPressed(Emitter<BadgeRegistrationState> emit) async {
    emit(state.copyWith());
  }
}
