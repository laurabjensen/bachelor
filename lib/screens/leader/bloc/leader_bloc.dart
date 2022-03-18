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

    add(LoadFromFirebase());
  }

  Future<void> _loadFromFirebase(Emitter<LeaderState> emit) async {
    var badgeRegistrations =
        await badgeRegistrationRepository.getBadgeRegistrationForLeader(userProfile);
    emit(state.copyWith(
        badgeRegistrations: badgeRegistrations,
        loadStatus: LeaderBadgeRegistrationLoadStatus.loaded));
  }

  @override
  Stream<LeaderState> mapEventToState(
    LeaderEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
