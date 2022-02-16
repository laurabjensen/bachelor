import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/repositories/image_repository.dart';

class BadgeRepository {
  Future<List<Badge>> getAllBadges() async {
    final snapshots = await FirebaseFirestore.instance.collection('badges').get();
    var badges = <Badge>[];
    for (var snapshot in snapshots.docs) {
      badges.add(Badge.fromJson(snapshot));
    }
    return badges;
  }

  Future<List<Badge>> getBadgesForUser(String userId) async {
    final snapshot =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get()).get('badges');
    var badges = <Badge>[];
    for (var badge in snapshot) {
      final badgeSnapshot = await FirebaseFirestore.instance.collection('badges').doc(badge).get();
      badges.add(Badge.fromJson(badgeSnapshot));
    }
    return badges;
  }

  Future<List<Badge>> getAllChallengeBadges() async {
    final allBadges = await getAllBadges();
    var badges = <Badge>[];
    for (var badge in allBadges) {
      if (badge.type == 'Udfordring') {
        badges.add(badge);
      }
    }
    return badges;
  }

  Future<List<Badge>> getAllEngagementBadges() async {
    final allBadges = await getAllBadges();
    var badges = <Badge>[];
    for (var badge in allBadges) {
      if (badge.type == 'Engagement') {
        badges.add(badge);
      }
    }
    return badges;
  }

  Future<List<Badge>> getUserChallengeBadges(String userId) async {
    final allBadges = await getBadgesForUser(userId);
    var badges = <Badge>[];
    for (var badge in allBadges) {
      if (badge.type == 'Udfordring') {
        badges.add(badge);
      }
    }
    return badges;
  }

  Future<List<Badge>> getUserEngagementBadges(String userId) async {
    final allBadges = await getBadgesForUser(userId);
    var badges = <Badge>[];
    for (var badge in allBadges) {
      if (badge.type == 'Engagement') {
        badges.add(badge);
      }
    }
    return badges;
  }
}
