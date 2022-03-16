import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/repositories/badge_repository.dart';

part 'badges_event.dart';
part 'badges_state.dart';

class BadgesBloc extends Bloc<BadgesEvent, BadgesState> {
  final badgeRepository = GetIt.instance.get<BadgeRepository>();
  final UserProfile userProfile;
  BadgesBloc({required this.userProfile}) : super(BadgesState()) {
    on<LoadBadges>((event, emit) => _loadBadges(emit));

    add(LoadBadges());
  }

  Future<void> _loadBadges(Emitter<BadgesState> emit) async {
    final allBadges = GetIt.instance.get<List<Badge>>();
    final allChallengeBadges =
        await badgeRepository.getAllChallengeBadges(allBadges);
    final allEngagementBadges =
        await badgeRepository.getAllEngagementBadges(allBadges);
    final userChallengeBadges =
        await badgeRepository.getUserChallengeBadges(userProfile.id);
    final userEngagementBadges =
        await badgeRepository.getUserEngagementBadges(userProfile.id);
    emit(state.copyWith(
        badgesStatus: BadgesStateStatus.loaded,
        allChallengeBadges: allChallengeBadges,
        allEngagementBadges: allEngagementBadges,
        userChallengeBadges: userChallengeBadges,
        userEngagementBadges: userEngagementBadges));
  }
}
