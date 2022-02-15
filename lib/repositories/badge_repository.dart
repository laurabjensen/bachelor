import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge.dart';

class BadgeRepository {
  Future<List<Badge>> getAllBadges() async {
    var snapshots = await FirebaseFirestore.instance.collection('badges').get();
    var badges = <Badge>[];
    for (var snapshot in snapshots.docs) {
      badges.add(Badge.fromJson(snapshot));
    }
    return badges;
  }
}
