import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/user_profile.dart';

class Patrol {
  final String id;
  final String name;
  final List<UserProfile> members;

  Patrol({required this.id, required this.name, required this.members});

  Patrol copyWith({
    String? id,
    String? name,
    List<UserProfile>? members,
  }) {
    return Patrol(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }

  Patrol.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(id: json.id, name: json.get('name'), members: []);
}
