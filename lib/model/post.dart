import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/comment.dart';

class Post {
  final String id;
  final BadgeRegistration badgeRegistration;
  final List<String> likes;
  final List<Comment> comments;
  final String user;
  final DateTime? approvedAt;

  Post(
      {required this.id,
      required this.badgeRegistration,
      required this.likes,
      required this.comments,
      required this.user,
      this.approvedAt});

  Post copyWith(
      {BadgeRegistration? badgeRegistration,
      List<String>? likes,
      List<Comment>? comments,
      String? user,
      DateTime? approvedAt}) {
    return Post(
        id: id,
        badgeRegistration: badgeRegistration ?? this.badgeRegistration,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        user: user ?? this.user,
        approvedAt: approvedAt ?? this.approvedAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'badgeRegistration': badgeRegistration.id,
      'likes': likes,
      'approvedAt': Timestamp.fromDate(approvedAt ?? DateTime.now()),
      'user': user,
    };
  }

  Post.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
          id: json.id,
          badgeRegistration: BadgeRegistration.empty,
          likes: List<String>.from(json.get('likes')),
          comments: [],
          user: '',
          approvedAt: json.get('approvedAt') != null
              ? (json.get('approvedAt') as Timestamp).toDate()
              : json.get('approvedAt'),
        );
}
