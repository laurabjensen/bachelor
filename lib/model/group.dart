import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spejder_app/model/user_profile.dart';

class Group {
  final String id;
  final String name;
  final int zipCode;
  final List<String> leaders;
  final List<String> members;
  const Group(
      {required this.id,
      required this.name,
      required this.zipCode,
      required this.leaders,
      required this.members});

  Group.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            name: json['name'].toString(),
            zipCode: json['zipcode'] as int,
            leaders: List<String>.from(json['leaders']),
            members: List<String>.from(json['members']));

  static const empty = Group(id: '', name: '', zipCode: 0, leaders: [], members: []);

  Group copyWith(
      {String? id,
      String? name,
      int? zipCode,
      List<String>? leaders,
      List<UserProfile>? leaderUserProfiles,
      List<String>? members}) {
    return Group(
        id: id ?? this.id,
        name: name ?? this.name,
        zipCode: zipCode ?? this.zipCode,
        leaders: leaders ?? this.leaders,
        members: members ?? this.members);
  }
}
