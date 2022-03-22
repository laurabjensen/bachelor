import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';

part 'leader_event.dart';
part 'leader_state.dart';

class LeaderBloc extends Bloc<LeaderEvent, LeaderState> {
  final BadgeRegistrationRepository badgeRegistrationRepository =
      GetIt.instance.get<BadgeRegistrationRepository>();
  final UserProfile userProfile;
  LeaderBloc({required this.userProfile}) : super(LeaderState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    on<ApproveBadge>((event, emit) => _approveBadge(event.badgeRegistration, emit));
    on<DenyBadge>((event, emit) => _denyBadge(event.badgeRegistration, emit));

    add(LoadFromFirebase());
  }

  Future<List<BadgeRegistration>> loadList() async {
    return await badgeRegistrationRepository.getBadgeRegistrationForLeader(userProfile);
  }

  Future<void> _loadFromFirebase(Emitter<LeaderState> emit) async {
    var badgeRegistrations = await loadList();
    emit(state.copyWith(
        badgeRegistrations: badgeRegistrations, loadStatus: LeaderLoadStatus.loaded));
  }

  Future<void> _approveBadge(BadgeRegistration badgeRegistration, Emitter<LeaderState> emit) async {
    emit(state.copyWith(registrationStatus: LeaderBadgeRegistrationStatus.loading));
    await badgeRegistrationRepository.approveBadgeRegistration(badgeRegistration);
    var badgeRegistrations = await loadList();
    emit(state.copyWith(
        badgeRegistrations: badgeRegistrations,
        registrationStatus: LeaderBadgeRegistrationStatus.finished));
  }

  Future<void> _denyBadge(BadgeRegistration badgeRegistration, Emitter<LeaderState> emit) async {
    emit(state.copyWith(registrationStatus: LeaderBadgeRegistrationStatus.loading));
    await badgeRegistrationRepository.denyBadgeRegistration(badgeRegistration);
    var badgeRegistrations = await loadList();
    emit(state.copyWith(
        badgeRegistrations: badgeRegistrations,
        registrationStatus: LeaderBadgeRegistrationStatus.finished));
  }
}
