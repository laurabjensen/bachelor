import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';

class UserProfile {
  final String id;
  final String email;
  final String name;
  final Group group;
  final Rank rank;
  final int seniority;

  const UserProfile(
      {required this.id,
      required this.email,
      required this.name,
      required this.group,
      required this.rank,
      required this.seniority});

  UserProfile copyWith(
      {String? id, String? email, String? name, Group? group, Rank? rank, int? seniority}) {
    return UserProfile(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        seniority: seniority ?? this.seniority);
  }

  UserProfile.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            email: json['email'].toString(),
            name: json['name'].toString(),
            group: Group.empty,
            rank: Rank.empty,
            seniority: json['seniority'] as int);

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'group': group.id,
      'rank': rank.id,
      'seniority': seniority
    };
  }

  String namePossessiveCase() {
    if (name.endsWith('s') || name.endsWith('x') || name.endsWith('z')) {
      return '$name\'';
    }
    return '${name}s';
  }
}
