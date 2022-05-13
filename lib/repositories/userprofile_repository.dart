import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:collection/collection.dart';

class UserProfileRepository {
  Future<UserProfile> getUserprofile(UserProfile userprofile) async {
    final group = await getGroupForUserprofile(userprofile.id);
    final rank = await getRankForUserprofile(userprofile.id);
    return userprofile.copyWith(
      group: group,
      rank: rank,
    );
  }

  Stream<UserProfile> getUser(String? userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => UserProfile.fromJson(snapshot));
  }

  Stream<List<UserProfile>> getAllUsersStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((event) => event.docs.map((e) => UserProfile.fromJson(e)).toList());
  }

  Stream<List<UserProfile>> getUsersFromListStream(List<String> idList) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', whereIn: idList)
        .snapshots()
        .map((event) => event.docs.map((e) => UserProfile.fromJson(e)).toList());
  }

  Future<List<UserProfile>> getAllUsers() async {
    var snapshot = await FirebaseFirestore.instance.collection('users').orderBy('name').get();
    var users = <UserProfile>[];
    for (var snap in snapshot.docs) {
      users.add(await getUserprofileFromDocSnapshot(snap));
    }
    return users;
  }

  Future<UserProfile?> getUserprofileFromId(String userId) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      var userprofile = UserProfile.fromJson(snapshot);
      return getUserprofile(userprofile);
    }
    return null;
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

  Future<List<UserProfile>> getUserprofilesFromList(List<String> idList) async {
    var userProfiles = <UserProfile>[];
    for (var id in idList) {
      final user = await getUserprofileFromId(id);
      if (user != null) {
        userProfiles.add(user);
      }
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

  Future<List<UserProfile>> getGroupUsersFromGroup(Group group) async {
    var members = <UserProfile>[];
    var groupMembers =
        (await FirebaseFirestore.instance.collection('groups').doc(group.id).get()).get('members');
    for (var member in groupMembers) {
      final user = await getUserprofileFromId(member);
      if (user != null) {
        members.add(user);
      }
    }

    return members;
  }

  Future<void> updateUserWithPost(String? userId, String postId) async {
    if (userId != null) {
      final userProfile = await getUserprofileFromId(userId);
      if (userProfile != null) {
        final posts = userProfile.posts + [postId];
        await FirebaseFirestore.instance.collection('users').doc(userId).update({'badges': posts});
      }
    }
  }

  Future<void> sendFriendRequest(
      {required UserProfile sender, required UserProfile receiver}) async {
    var updatedSender = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(sender.id).get());
    var updatedReceiver = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(receiver.id).get());

    if (!updatedSender.friendRequestsSend.contains(updatedReceiver.id)) {
      var sendList = updatedSender.friendRequestsSend + [updatedReceiver.id];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedSender.id)
          .update({'friendRequestsSend': sendList});

      var receivedList = updatedReceiver.friendRequestsReceived + [updatedSender.id];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedReceiver.id)
          .update({'friendRequestsReceived': receivedList});
    }
  }

  Future<void> cancelFriendRequest(
      {required UserProfile sender, required UserProfile receiver}) async {
    var updatedSender = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(sender.id).get());
    var updatedReceiver = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(receiver.id).get());

    var sendList = updatedSender.friendRequestsSend;
    sendList.remove(updatedReceiver.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedSender.id)
        .update({'friendRequestsSend': sendList});

    var receivedList = updatedReceiver.friendRequestsReceived;
    receivedList.remove(updatedSender.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedReceiver.id)
        .update({'friendRequestsReceived': receivedList});
  }

  Future<void> acceptFriendRequest(
      {required UserProfile sender, required UserProfile receiver}) async {
    var updatedSender = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(sender.id).get());
    var updatedReceiver = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(receiver.id).get());

    var senderFriendList = updatedSender.friends + [updatedReceiver.id];
    var senderRequestList = updatedSender.friendRequestsSend;
    senderRequestList.remove(updatedReceiver.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedSender.id)
        .update({'friends': senderFriendList, 'friendRequestsSend': senderRequestList});

    var receiverFriendList = updatedReceiver.friends + [updatedSender.id];
    var receiverRequestList = updatedReceiver.friendRequestsReceived;
    receiverRequestList.remove(updatedSender.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedReceiver.id)
        .update({'friends': receiverFriendList, 'friendRequestsReceived': receiverRequestList});
  }

  Future<void> deleteFriend(
      {required UserProfile userProfile, required UserProfile currentUser}) async {
    var updatedUserProfile = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(userProfile.id).get());
    var updatedCurrentUser = UserProfile.fromJson(
        await FirebaseFirestore.instance.collection('users').doc(currentUser.id).get());

    var userProfileFriendList = updatedUserProfile.friends;
    userProfileFriendList.remove(updatedCurrentUser.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedUserProfile.id)
        .update({'friends': userProfileFriendList});

    var currentUserFriendList = updatedCurrentUser.friends;
    currentUserFriendList.remove(updatedUserProfile.id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedCurrentUser.id)
        .update({'friends': currentUserFriendList});
  }

  Future<List<UserProfile>> getMembersNotInPatrol(Group group) async {
    var members = <UserProfile>[];
    var groupMembers =
        (await FirebaseFirestore.instance.collection('groups').doc(group.id).get()).get('members');
    for (var member in groupMembers) {
      var hasNoPatrol = ((await FirebaseFirestore.instance.collection('users').doc(member).get())
              .get('patrol') as String)
          .isEmpty;
      if (hasNoPatrol) {
        final user = await getUserprofileFromId(member);
        if (user != null) {
          members.add(user);
        }
      }
    }

    return members;
  }
}
