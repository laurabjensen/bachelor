import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/repositories/group_repository.dart';

part 'badge_registration_event.dart';
part 'badge_registration_state.dart';

class BadgeRegistrationBloc extends Bloc<BadgeRegistrationEvent, BadgeRegistrationState> {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();

  BadgeRegistrationBloc() : super(BadgeRegistrationState()) {
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));

    add(LoadFromFirebase());
  }

  Future<void> _loadFromFirebase(Emitter<BadgeRegistrationState> emit) async {
    //final groups = GetIt.instance.get<List<Leader>>();
    // emit(state.copyWith(leaders: leaders,));
    final groups = GetIt.instance.get<List<Group>>();
    emit(state.copyWith(
      groups: groups,
    ));
  }
}
