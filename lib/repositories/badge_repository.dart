import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';

class BadgeRepository {
  Future<List<Badge>> getAllBadges() async {
    final snapshots = await FirebaseFirestore.instance.collection('badges').get();
    var badges = <Badge>[];
    for (var snapshot in snapshots.docs) {
      badges.add(await getBadge(snapshot));
    }
    return badges;
  }

  Future<Badge> getBadge(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    var badge = Badge.fromJson(snapshot);
    var levelsCollection = await FirebaseFirestore.instance
        .collection('badges')
        .doc(snapshot.id)
        .collection('levels')
        .get();
    var levels = <BadgeSpecific>[];
    levels.add(BadgeSpecific.fromJson(badge, levelsCollection.docs[3]));
    levels.add(BadgeSpecific.fromJson(badge, levelsCollection.docs[1]));
    levels.add(BadgeSpecific.fromJson(badge, levelsCollection.docs[2]));
    levels.add(BadgeSpecific.fromJson(badge, levelsCollection.docs[0]));
    return badge.copyWith(levels: levels);
  }

  Future<List<Badge>> getBadgesForUser(String userId) async {
    final badges = GetIt.instance.get<List<Badge>>();
    final snapshot = (await FirebaseFirestore.instance.collection('users').doc(userId).get())
        .get('badges') as List<dynamic>;
    return badges.where((element) => snapshot.contains(element.id)).toList();
  }

  Future<List<Badge>> getAllChallengeBadges(List<Badge> allBadges) async {
    //final allBadges = await getAllBadges();
    var badges = <Badge>[];
    for (var badge in allBadges) {
      if (badge.type == 'Udfordring') {
        badges.add(badge);
      }
    }
    return badges;
  }

  Future<List<Badge>> getAllEngagementBadges(List<Badge> allBadges) async {
    //final allBadges = await getAllBadges();
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
