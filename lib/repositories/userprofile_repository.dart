import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:collection/collection.dart';

class UserProfileRepository {
  Future<UserProfile> getUserprofile(UserProfile userprofile) async {
    final group = await getGroupForUserprofile(userprofile.id);
    final rank = await getRankForUserprofile(userprofile.id);
    //final friends = await getFriendsForUser(userprofile.id);
    //final badges = await getBadgeRegistrationsForUser(userprofile.id);
    return userprofile.copyWith(
      group: group,
      rank: rank,
    );
  }

  Stream<UserProfile> getUser(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => UserProfile.fromJson(snapshot));
  }

  Future<UserProfile> reloadUserprofile(UserProfile userprofile) async {
    final friends = await getFriendsForUser(userprofile.id);
    final posts = await getPostsForUser(userprofile.id);
    return userprofile.copyWith(friends: friends, posts: posts);
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
    return GetIt.instance.get<List<Group>>().firstWhere((element) => element.id == groupId);
  }

  Future<Rank> getRankForUserprofile(String userId) async {
    var rankId = (await FirebaseFirestore.instance.collection('users').doc(userId).get())
        .get('rank')
        .toString();
    return GetIt.instance.get<List<Rank>>().firstWhere((element) => element.id == rankId);
  }

  Future<List<String>> getFriendsForUser(String userId) async {
    final userSnapshot =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get()).get('friends');
    var friends = <String>[];
    for (var friend in userSnapshot) {
      friends.add(friend);
    }
    return friends;
  }

  Future<List<String>> getPostsForUser(String userId) async {
    final userSnapshot =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get()).get('badges');
    var badges = <String>[];
    for (var badge in userSnapshot) {
      badges.add(badge);
    }
    return badges;
  }

  Future<List<UserProfile>> getFriendUserProfilesForUser(List<String> friends) async {
    var userProfiles = <UserProfile>[];
    for (var friend in friends) {
      userProfiles.add(await getUserprofileFromId(friend));
    }
    return userProfiles.sortedBy((element) => element.name);
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

  Future<List<UserProfile>> getGroupUsersFromGroup(Group group) async {
    var members = <UserProfile>[];
    //Check firebase
    var firebaseList = await FirebaseFirestore.instance
        .collection('users')
        .where('group', isEqualTo: group.id)
        .get();
    // If firebase list is not the same length as the preloaded lists length then update the list
    if (firebaseList.docs.length != group.members.length) {
      group = await GetIt.instance.get<GroupRepository>().updateGroupSingleton(group);
    }
    // Get all firebase users
    var allUsers = GetIt.instance.get<List<UserProfile>>();

    //Loop through all id's and check if all users conatin a user with that id and then add it to the members list.
    for (var member in group.members) {
      var temp = allUsers.firstWhereOrNull((element) => element.id == member);
      if (temp != null) {
        members.add(temp);
      }
    }
    return members;
  }

  Future<void> updateUserBadgeList(String userProfileId, String postId) async {
    var path = FirebaseFirestore.instance.collection('users').doc(userProfileId);
    var list = (await path.get()).get('badges');
    list.add(postId);
    await path.update({'badges': list});
  }
}
