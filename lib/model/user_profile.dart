import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';

class UserProfile {
  final String id;
  final int age;
  final String email;
  final String name;
  final Group group;
  final Rank rank;
  final int seniority;
  final String description;
  final String imageUrl;
  final List<String> badgeRegistrations;
  final List<String> friends;

  const UserProfile({
    required this.id,
    required this.age,
    required this.email,
    required this.name,
    required this.group,
    required this.rank,
    required this.seniority,
    required this.description,
    required this.imageUrl,
    required this.badgeRegistrations,
    required this.friends,
  });

  UserProfile copyWith(
      {String? id,
      int? age,
      String? email,
      String? name,
      Group? group,
      Rank? rank,
      int? seniority,
      String? description,
      String? imageUrl,
      List<String>? badgeRegistrations,
      List<String>? friends}) {
    return UserProfile(
        id: id ?? this.id,
        age: age ?? this.age,
        email: email ?? this.email,
        name: name ?? this.name,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        seniority: seniority ?? this.seniority,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        badgeRegistrations: badgeRegistrations ?? this.badgeRegistrations,
        friends: friends ?? this.friends);
  }

  UserProfile.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            age: json.get('age'),
            email: json['email'].toString(),
            name: json['name'].toString(),
            group: Group.empty,
            rank: Rank.empty,
            seniority: json['seniority'] as int,
            description: json['description'].toString(),
            imageUrl: json['imageUrl'].toString(),
            badgeRegistrations: [],
            friends: []);

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'age': age,
      'name': name,
      'group': group.id,
      'rank': rank.id,
      'seniority': seniority,
      'description': description,
      'imageUrl': imageUrl,
      'friends': friends,
      'badges': badgeRegistrations,
    };
  }

  static const empty = UserProfile(
      id: '',
      age: 0,
      email: '',
      name: '',
      group: Group.empty,
      rank: Rank.empty,
      seniority: 0,
      description: '',
      imageUrl: '',
      badgeRegistrations: [],
      friends: []);

  String namePossessiveCase() {
    if (name.endsWith('s') || name.endsWith('x') || name.endsWith('z')) {
      return '$name\'';
    }
    return '${name}s';
  }
}
