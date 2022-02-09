import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';

class UserProfileRepository {
  Future<UserProfile> getUserprofile(String uid) async {
    var userprofile =
        UserProfile.fromJson(await FirebaseFirestore.instance.collection('users').doc(uid).get());
    final group = await getGroupForUserprofile(uid);
    final rank = await getRankForUserprofile(uid);
    return userprofile.copyWith(group: group, rank: rank);
  }

  Future<Group> getGroupForUserprofile(String uid) async {
    var groupId = (await FirebaseFirestore.instance.collection('users').doc(uid).get())
        .get('group')
        .toString();
    return Group.fromJson(await FirebaseFirestore.instance.collection('groups').doc(groupId).get());
  }

  Future<Rank> getRankForUserprofile(String uid) async {
    var rankId = (await FirebaseFirestore.instance.collection('users').doc(uid).get())
        .get('rank')
        .toString();
    return Rank.fromJson(await FirebaseFirestore.instance.collection('ranks').doc(rankId).get());
  }
}
