import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

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
  final List<String> posts;
  final List<String> friends;
  final List<String> friendRequestsSend;
  final List<String> friendRequestsReceived;
  final String patrolId;

  const UserProfile(
      {required this.id,
      required this.age,
      required this.email,
      required this.name,
      required this.group,
      required this.rank,
      required this.seniority,
      required this.description,
      required this.imageUrl,
      required this.posts,
      required this.friends,
      required this.friendRequestsSend,
      required this.friendRequestsReceived,
      required this.patrolId});

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
      List<String>? posts,
      List<String>? friends,
      List<String>? friendRequestsSend,
      List<String>? friendRequestsReceived,
      String? patrolId}) {
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
        posts: posts ?? this.posts,
        friends: friends ?? this.friends,
        friendRequestsSend: friendRequestsSend ?? this.friendRequestsSend,
        friendRequestsReceived: friendRequestsReceived ?? this.friendRequestsReceived,
        patrolId: patrolId ?? this.patrolId);
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
            posts: List<String>.from(json['badges']),
            friends: List<String>.from(json['friends']),
            friendRequestsSend: List<String>.from(json['friendRequestsSend']),
            friendRequestsReceived: List<String>.from(json['friendRequestsReceived']),
            patrolId: json.data()?.containsKey('patrol') ?? false ? json['patrol'].toString() : '');

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
      'badges': posts,
      'friendRequestsSend': friendRequestsSend,
      'friendRequestsReceived': friendRequestsReceived,
      'patrol': patrolId
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
      posts: [],
      friends: [],
      friendRequestsSend: [],
      friendRequestsReceived: [],
      patrolId: '');

  String namePossessiveCase() {
    if (name.endsWith('s') || name.endsWith('x') || name.endsWith('z')) {
      return '$name\'';
    }
    return '${name}s';
  }

  String badgeCase() {
    if ((posts.length == 1)) {
      return 'Mærke';
    }
    return 'Mærker';
  }

  String friendsCase() {
    if ((friends.length == 1)) {
      return 'Veninde';
    }
    return 'Veninder';
  }
}
