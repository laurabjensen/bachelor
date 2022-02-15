import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/repositories/badge_repository.dart';

part 'badges_event.dart';
part 'badges_state.dart';

class BadgesBloc extends Bloc<BadgesEvent, BadgesState> {
  final badgeRepository = GetIt.instance.get<BadgeRepository>();
  BadgesBloc() : super(BadgesState()) {
    on<LoadBadges>((event, emit) => _loadBadges(emit));

    add(LoadBadges());
  }

  Future<void> _loadBadges(Emitter<BadgesState> emit) async {
    final badges = await badgeRepository.getAllBadges();
    emit(state.copyWith(badgesStatus: BadgesStateStatus.loaded, allBadges: badges));
  }
}
