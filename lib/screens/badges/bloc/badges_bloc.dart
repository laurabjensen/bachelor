import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/repositories/badge_repository.dart';

part 'badges_event.dart';
part 'badges_state.dart';

class BadgesBloc extends Bloc<BadgesEvent, BadgesState> {
  final badgeRepository = GetIt.instance.get<BadgeRepository>();
  final badgeRegistrationRepository = GetIt.instance.get<BadgeRegistrationRepository>();
  final UserProfile userProfile;
  BadgesBloc({required this.userProfile}) : super(BadgesState()) {
    on<LoadAllBadges>((event, emit) => _loadAllBadges(emit));
    //on<LoadUserBadges>((event, emit) => _loadUserBadges(emit));
    add(LoadAllBadges());
  }

  Future<void> _loadAllBadges(Emitter<BadgesState> emit) async {
    final allBadges = GetIt.instance.get<List<Badge>>();
    final allChallengeBadges = await badgeRepository.getAllChallengeBadges(allBadges);
    final allEngagementBadges = await badgeRepository.getAllEngagementBadges(allBadges);
    emit(state.copyWith(
      allChallengeBadges: allChallengeBadges,
      allEngagementBadges: allEngagementBadges,
    ));

    final badgeRegistrations =
        await badgeRegistrationRepository.getBadgeRegistrationsFromUserProfile(userProfile);
    emit(state.copyWith(
        badgesStatus: BadgesStateStatus.loaded,
        userChallengeBadges: badgeRegistrations
            .where((element) => element.badgeSpecific.badge.type == 'Udfordring')
            .toList(),
        userEngagementBadges: badgeRegistrations
            .where((element) => element.badgeSpecific.badge.type == 'Engagement')
            .toList()));
  }

  Future<void> _loadUserBadges(Emitter<BadgesState> emit) async {
    emit(state.copyWith(badgesStatus: BadgesStateStatus.loading));
    final badgeRegistrations =
        await badgeRegistrationRepository.getBadgeRegistrationsFromUserProfile(userProfile);
    emit(state.copyWith(
        badgesStatus: BadgesStateStatus.loaded,
        userChallengeBadges: badgeRegistrations
            .where((element) => element.badgeSpecific.badge.type == 'Udfordring')
            .toList(),
        userEngagementBadges: badgeRegistrations
            .where((element) => element.badgeSpecific.badge.type == 'Engagement')
            .toList()));
  }
}
