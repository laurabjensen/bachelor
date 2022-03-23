import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

class GroupRepository {
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
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

  Future<List<String>> getLeadersForGroup(dynamic snapshot) async {
    var leaders = <String>[];
    for (var leader in snapshot) {
      leaders.add(leader);
    }
    return leaders;
  }

  Future<List<UserProfile>> getLeaderUserProfilesForGroup(Group group) async {
    var leaders = <UserProfile>[];
    for (var leader in group.leaders) {
      final leaderSnapshot = await FirebaseFirestore.instance.collection('users').doc(leader).get();
      leaders.add(await userProfileRepository.getUserprofileFromDocSnapshot(leaderSnapshot));
    }
    return leaders;
  }

  Future<Group> addLeaderToGroup(Group group, String userId) async {
    var leaders = group.leaders;
    leaders.add(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'leaders': leaders});

    return group.copyWith(leaders: leaders);
  }

  Future<Group> removeLeaderFromGroup(Group group, String userId) async {
    var leaders = group.leaders;
    leaders.remove(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'leaders': leaders});

    return group.copyWith(leaders: leaders);
  }

  Future<Group> updateGroupSingleton(Group group) async {
    var groupUpdated =
        Group.fromJson(await FirebaseFirestore.instance.collection('groups').doc(group.id).get());
    var list = GetIt.instance.get<List<Group>>();
    list.removeWhere((element) => element.id == group.id);
    list.add(groupUpdated);
    GetIt.instance.registerSingleton<List<Group>>(list);
    return groupUpdated;
  }

  Future<Group> addMemberToGroup(Group group, String userId) async {
    var members = group.members;
    members.add(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'members': members});

    return group.copyWith(members: members);
  }

  Future<Group> removeMemberFromGroup(Group group, String userId) async {
    var members = group.members;
    members.remove(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'members': members});

    return group.copyWith(members: members);
  }
}
