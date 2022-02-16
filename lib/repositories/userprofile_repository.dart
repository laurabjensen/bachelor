import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';

class UserProfileRepository {
  Future<UserProfile> getUserprofile(UserProfile userprofile) async {
    final group = await getGroupForUserprofile(userprofile.id);
    final rank = await getRankForUserprofile(userprofile.id);
    return userprofile.copyWith(group: group, rank: rank);
  }

  Future<UserProfile> getUserprofileFromId(String userId) async {
    var userprofile = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(userId).get());
    return getUserprofile(userprofile);
  }

  Future<UserProfile> getUserprofileFromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) async {
    var userprofile = UserProfile.fromJson(json);
    return getUserprofile(userprofile);
  }

  Future<Group> getGroupForUserprofile(String userId) async {
    var groupId = (await FirebaseFirestore.instance.collection('users').doc(userId).get())
        .get('group')
        .toString();
    return Group.fromJson(await FirebaseFirestore.instance.collection('groups').doc(groupId).get());
  }

  Future<Rank> getRankForUserprofile(String userId) async {
    var rankId = (await FirebaseFirestore.instance.collection('users').doc(userId).get())
        .get('rank')
        .toString();
    return Rank.fromJson(await FirebaseFirestore.instance.collection('ranks').doc(rankId).get());
  }

  Future<List<UserProfile>> getFriendsForUser(String userId) async {
    final userSnapshot =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get()).get('friends');
    var friends = <UserProfile>[];
    for (var friend in userSnapshot) {
      final friendSnapshot = await FirebaseFirestore.instance.collection('users').doc(friend).get();
      friends.add(await getUserprofileFromDocSnapshot(friendSnapshot));
    }
    return friends;
  }
}
