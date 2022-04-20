import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:collection/collection.dart';

class GroupRepository {
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  Group? getGroupFromConstant(String id) {
    return GetIt.instance.get<List<Group>>().firstWhereOrNull((element) => element.id == id);
  }

  Future<List<Group>> getGroups() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('groups')
        .orderBy('name', descending: false)
        .get();
    var groups = <Group>[];
    for (var snap in snapshot.docs) {
      groups.add(Group.fromJson(snap));
    }
    return groups;
  }

  Stream<List<Group>> getGroupsStream() {
    return FirebaseFirestore.instance
        .collection('groups')
        .orderBy('name', descending: false)
        .snapshots()
        .map((event) => event.docs.map((e) => Group.fromJson(e)).toList());
  }

  /*Future<List<String>> getLeadersForGroup(dynamic snapshot) async {
    var leaders = <String>[];
    for (var leader in snapshot) {
      leaders.add(leader);
    }
    return leaders;
  }*/

  Future<List<UserProfile>> getLeaderUserProfilesForGroup(Group group) async {
    final updatedGroup = getGroupFromConstant(group.id);
    var leaders = <UserProfile>[];
    if (updatedGroup != null) {
      for (var leader in group.leaders) {
        final leaderSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(leader).get();
        leaders.add(await userProfileRepository.getUserprofileFromDocSnapshot(leaderSnapshot));
      }
    }
    return leaders;
  }

  Future<Group> addLeaderToGroup(Group group, String userId) async {
    var leaders = <String>[];
    final updatedGroup = getGroupFromConstant(group.id);
    if (updatedGroup != null) {
      leaders = updatedGroup.leaders;
      leaders.add(userId);
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update({'leaders': leaders});
    }
    return group.copyWith(leaders: leaders);
  }

  Future<Group> removeLeaderFromGroup(Group group, String userId) async {
    var leaders = <String>[];
    final updatedGroup = getGroupFromConstant(group.id);
    if (updatedGroup != null) {
      leaders = updatedGroup.leaders;
      leaders.remove(userId);
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update({'leaders': leaders});
    }
    return group.copyWith(leaders: leaders);
  }

  Future<Group> addMemberToGroup(Group group, String userId) async {
    var members = <String>[];
    final updatedGroup = getGroupFromConstant(group.id);
    if (updatedGroup != null) {
      members = updatedGroup.members;
      members.add(userId);
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update({'members': members});
    }

    return group.copyWith(members: members);
  }

  Future<Group> removeMemberFromGroup(Group group, String userId) async {
    var members = <String>[];
    final updatedGroup = getGroupFromConstant(group.id);
    if (updatedGroup != null) {
      members = updatedGroup.members;
      members.remove(userId);
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update({'members': members});
    }

    return group.copyWith(members: members);
  }

  Future<void> createPatrol(
      Group group, String name, List<UserProfile> selectedUserProfiles) async {
    final map = {'name': name, 'members': selectedUserProfiles.map((e) => e.id).toList()};
    var snap = await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .collection('patrols')
        .add(map);
    for (var member in selectedUserProfiles) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(member.id)
          .update({'patrol': snap.id});
    }
  }
}
