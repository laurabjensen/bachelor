import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spejder_app/model/user_profile.dart';

class Group {
  final String id;
  final String name;
  final int zipCode;
  final List<UserProfile> leaders;
  const Group({required this.id, required this.name, required this.zipCode, required this.leaders});

  Group.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            name: json['name'].toString(),
            zipCode: json['zipcode'] as int,
            leaders: []);

  static const empty = Group(id: '', name: '', zipCode: 0, leaders: []);

  Group copyWith({
    String? id,
    String? name,
    int? zipCode,
    List<UserProfile>? leaders,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      zipCode: zipCode ?? this.zipCode,
      leaders: leaders ?? this.leaders,
    );
  }
}
