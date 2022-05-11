import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/posts_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'badges_event.dart';
part 'badges_state.dart';

class BadgesBloc extends Bloc<BadgesEvent, BadgesState> {
  final badgeRepository = GetIt.instance.get<BadgeRepository>();
  final badgeRegistrationRepository = GetIt.instance.get<BadgeRegistrationRepository>();
  final postRepository = GetIt.instance.get<PostsRepository>();
  UserProfile userProfile;

  BadgesBloc({required this.userProfile}) : super(BadgesState()) {
    on<UserStreamStarted>((event, emit) async {
      await emit
          .onEach<UserProfile>(GetIt.instance.get<UserProfileRepository>().getUser(userProfile.id),
              onData: (updatedUser) {
        userProfile = updatedUser;
        add(LoadUserBadges());
      });
    }, transformer: restartable());
    on<RegistrationStreamStarted>((event, emit) async {
      await emit.onEach<List<BadgeRegistration>>(
          badgeRegistrationRepository.streamBadgeRegistrationForUser(userProfile.id),
          onData: (updatedList) {
        add(LoadUserBadges());
      });
    }, transformer: restartable());

    on<LoadAllBadges>((event, emit) => _loadAllBadges(emit));
    on<LoadUserBadges>((event, emit) => _loadAllUserBadges(emit));
    on<DescriptionUpdated>(
        (event, emit) => _descriptionUpdated(event.badgeRegistration, event.description, emit));
    on<EditingToggled>((event, emit) => _editingToggled(emit));

    add(UserStreamStarted());
    add(RegistrationStreamStarted());
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
  }

  Future<void> _loadAllUserBadges(Emitter<BadgesState> emit) async {
    userProfile =
        await GetIt.instance.get<UserProfileRepository>().getUserprofileFromId(userProfile.id);
    final allBadges = GetIt.instance.get<List<Badge>>();
    final posts = await postRepository.getPostsFromUserProfile(userProfile);
    final allRegistrations =
        await badgeRegistrationRepository.getBadgeRegistrationsForUser(userProfile.id);
    final approvedBadges = posts.map((e) => e.badgeRegistration).toList();
    emit(state.copyWith(
        badgesStatus: BadgesStateStatus.loaded,
        approvedBadges: approvedBadges,
        allJubileeBadges: await badgeRepository.getAllJubileeBadges(allBadges, userProfile),
        userChallengeBadges: approvedBadges
            .where((element) => element.badgeSpecific.badge.type == 'Udfordring')
            .toList(),
        userEngagementBadges: approvedBadges
            .where((element) => element.badgeSpecific.badge.type == 'Engagement')
            .toList(),
        userJubileeBadges: approvedBadges
            .where((element) => element.badgeSpecific.badge.type == 'Jubilæum')
            .toList(),
        registrations: allRegistrations));
  }

  Future<void> _descriptionUpdated(
      BadgeRegistration? badgeRegistration, String description, Emitter<BadgesState> emit) async {
    badgeRegistration = await badgeRegistrationRepository.updateRegistrationDescription(
        badgeRegistration, description);
    var approvedBadges = state.approvedBadges;
    var registrations = state.registrations;
    approvedBadges.removeWhere((element) => element.id == badgeRegistration?.id);
    approvedBadges.add(badgeRegistration!);
    registrations.removeWhere((element) => element.id == badgeRegistration?.id);
    registrations.add(badgeRegistration);
    emit(state.copyWith(
        approvedBadges: approvedBadges,
        registrations: registrations,
        userChallengeBadges: approvedBadges
            .where((element) => element.badgeSpecific.badge.type == 'Udfordring')
            .toList(),
        userEngagementBadges: approvedBadges
            .where((element) => element.badgeSpecific.badge.type == 'Engagement')
            .toList(),
        isEditing: false));
  }

  Future<void> _editingToggled(Emitter<BadgesState> emit) async {
    emit(state.copyWith(isEditing: !state.isEditing));
  }
}
