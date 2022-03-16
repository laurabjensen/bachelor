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
      groups.add(
          (Group.fromJson(snap)).copyWith(leaders: await getLeadersForGroup(snap.get('leaders'))));
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

  Future<void> addLeaderToGroup(Group group, String userId) async {
    var leaders = group.leaderUserProfiles!.map((e) => e.id).toList();
    leaders.add(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'leaders': leaders});
  }

  Future<void> removeLeaderFromGroup(Group group, String userId) async {
    var leaders = group.leaders;
    leaders.remove(userId);
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .update({'leaders': leaders});

    if (group.leaderUserProfiles != null && group.leaderUserProfiles!.isNotEmpty) {
      var leaderUserProfiles = group.leaderUserProfiles!.map((e) => e.id).toList();
      leaderUserProfiles.remove(userId);
    }
  }
}
