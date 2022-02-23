import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/group.dart';

class GroupRepository {
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
}
