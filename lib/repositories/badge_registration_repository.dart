import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:collection/collection.dart';

class BadgeRegistrationRepository {
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
  final BadgeRepository badgeRepository = GetIt.instance.get<BadgeRepository>();

  Future<void> createBadgeRegistration(BadgeRegistration badgeRegistration) async {
    var map = badgeRegistration.toMap();
    await FirebaseFirestore.instance.collection('badgeRegistrations').add(map);
  }

  Future<BadgeRegistration> getBadgeRegistrationFromId(String badgeRegistrationId) async {
    var snap = await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .doc(badgeRegistrationId)
        .get();
    var badgeRegistration = BadgeRegistration.fromJson(snap);
    //final user = await userProfileRepository.getUserprofileFromId(snap.get('user'));
    //final leader = await userProfileRepository.getUserprofileFromId(snap.get('leader'));
    final badgeSpecific =
        await badgeRepository.getBadgeSpecific(snap.get('badge'), snap.get('rank'));
    return badgeRegistration.copyWith(badgeSpecific: badgeSpecific);
  }

  Stream<List<BadgeRegistration>> streamBadgeRegistrationForLeader(String leaderId) {
    return FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .where('leader', isEqualTo: leaderId)
        .snapshots()
        .map((event) => event.docs.map((e) => BadgeRegistration.fromJson(e)).toList());
  }

  Stream<List<BadgeRegistration>> streamBadgeRegistrationForUser(String userId) {
    return FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .where('user', isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.map((e) => BadgeRegistration.fromJson(e)).toList());
  }

  Future<List<BadgeRegistration>> getBadgeRegistrationsForUser(String userId) async {
    var badges = <BadgeRegistration>[];
    var snapshot = await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .where('user', isEqualTo: userId)
        .get();
    for (var snap in snapshot.docs) {
      var badgeRegistration = BadgeRegistration.fromJson(snap);
      //final leader = await userProfileRepository.getUserprofileFromId(snap.get('leader'));
      final badgeSpecific =
          await badgeRepository.getBadgeSpecific(snap.get('badge'), snap.get('rank'));
      badges.add(badgeRegistration.copyWith(badgeSpecific: badgeSpecific));
    }
    return badges;
  }

  Future<List<BadgeRegistration>> getBadgeRegistrationForLeader(UserProfile userProfile) async {
    var list = <BadgeRegistration>[];
    var snapshot = await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .where('leader', isEqualTo: userProfile.id)
        .get();
    for (var snap in snapshot.docs) {
      if (snap.get('waitingOnLeader')) {
        var registration = await getBadgeRegistrationFromId(snap.id);
        registration = registration.copyWith(
            userProfile:
                await userProfileRepository.getUserprofileFromId(registration.userProfileId));
        list.add(registration);
      }
    }
    return list;
  }

  // Wating on leader = false now since the leader makes an action on the badge. Updates firebase values
  Future<BadgeRegistration> approveBadgeRegistration(BadgeRegistration badgeRegistration) async {
    badgeRegistration = badgeRegistration.copyWith(
        waitingOnLeader: false, denied: false, approvedAt: DateTime.now());
    await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .doc(badgeRegistration.id)
        .update(badgeRegistration.toMap());
    return badgeRegistration;
  }

  // Wating on leader = false now since the leader makes an action on the badge. Updates firebase values
  Future<void> denyBadgeRegistration(BadgeRegistration badgeRegistration) async {
    badgeRegistration = badgeRegistration.copyWith(waitingOnLeader: false, denied: true);
    await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .doc(badgeRegistration.id)
        .update(badgeRegistration.toMap());
  }

  Future<BadgeRegistration?> updateRegistrationDescription(
      BadgeRegistration? badgeRegistration, String description) async {
    if (badgeRegistration != null) {
      badgeRegistration = badgeRegistration.copyWith(description: description);
      await FirebaseFirestore.instance
          .collection('badgeRegistrations')
          .doc(badgeRegistration.id)
          .update({'description': description});
    }
    return badgeRegistration;
  }

  Future<List<String>> getUserIdForBadgeSpecific(String badgeId, Rank rank) async {
    return (await FirebaseFirestore.instance
            .collection('badgeRegistrations')
            .where('badge', isEqualTo: badgeId)
            .where('rank', isEqualTo: rank.id)
            .where('waitingOnLeader', isEqualTo: false)
            .where('denied', isEqualTo: false)
            .get())
        .docs
        .map((e) => e.get('user') as String)
        .toList();
  }
}
