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
    final badges = await GetIt.instance
        .get<BadgeRepository>()
        .getBadgesForUser(userprofile.id);
    return userprofile.copyWith(
        group: group, rank: rank, friends: friends, badges: badges);
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
    var groupId =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get())
            .get('group')
            .toString();
    return GetIt.instance
        .get<List<Group>>()
        .firstWhere((element) => element.id == groupId);
  }

  Future<Rank> getRankForUserprofile(String userId) async {
    var rankId =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get())
            .get('rank')
            .toString();
    return GetIt.instance
        .get<List<Rank>>()
        .firstWhere((element) => element.id == rankId);
  }

  Future<List<String>> getFriendsForUser(String userId) async {
    final userSnapshot =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get())
            .get('friends');
    var friends = <String>[];
    for (var friend in userSnapshot) {
      friends.add(friend);
    }
    return friends;
  }

  Future<List<UserProfile>> getFriendUserProfilesForUser(
      List<String> friends) async {
    var userProfiles = <UserProfile>[];
    for (var friend in friends) {
      userProfiles.add(await getUserprofileFromId(friend));
    }
    return userProfiles;
  }

// TODO: FIKS HER
  Future<void> updateUserprofile(UserProfile userprofile) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userprofile.id)
        .update(userprofile.toJson());
  }

  Future<List<UserProfile>> getAllUsers() async {
    var snapshot = await FirebaseFirestore.instance.collection('users').get();
    var users = <UserProfile>[];
    for (var snap in snapshot.docs) {
      users.add(await getUserprofileFromDocSnapshot(snap));
    }
    return users;
  }
}
