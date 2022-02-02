import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/group.dart';

class GroupRepository {
  Future<List<Group>> getGroups() async {
    var snapshot = await FirebaseFirestore.instance.collection('groups').get();
    return snapshot.docs.map((e) => Group.fromJson(e)).toList();
  }
}
