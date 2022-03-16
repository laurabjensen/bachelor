import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

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
    final user = await userProfileRepository.getUserprofileFromId(snap.get('user'));
    final leader = await userProfileRepository.getUserprofileFromId(snap.get('leader'));
    final badgeSpecific =
        await badgeRepository.getBadgeSpecific(snap.get('badge'), snap.get('rank'));
    return badgeRegistration.copyWith(
        userProfile: user, leader: leader, badgeSpecific: badgeSpecific);
  }

  //TODO!: Hvorfor vil den ikke lave et index i firestore???
  Future<List<BadgeRegistration>> getBadgeRegistrationFromBadgeAndUser(
      Badge badge, UserProfile userProfile) async {
    var list = <BadgeRegistration>[];
    var snapshot = await FirebaseFirestore.instance
        .collection('badgeRegistrations')
        .where('user', isEqualTo: userProfile.id)
        .where('badge', isEqualTo: badge.id)
        .get();
    for (var snap in snapshot.docs) {
      list.add(await getBadgeRegistrationFromId(snap.id));
    }
    return list;
  }
}
