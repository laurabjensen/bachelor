import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_repository.dart';

class UserProfileRepository {
  Future<UserProfile> getUserprofile(UserProfile userprofile) async {
    final group = await getGroupForUserprofile(userprofile.id);
    final rank = await getRankForUserprofile(userprofile.id);
    final friends = await getFriendsForUser(userprofile.id);
    final badges = await GetIt.instance.get<BadgeRepository>().getBadgesForUser(userprofile.id);
    return userprofile.copyWith(group: group, rank: rank, friends: friends, badges: badges);
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

// TODO: FIKS HER
  Future<void> updateUserprofile(UserProfile userprofile) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userprofile.id)
        .update(userprofile.toJson());
  }
}
