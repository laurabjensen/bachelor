import 'package:cloud_firestore/cloud_firestore.dart';

class Rank {
  final String id;
  final String title;

  const Rank({required this.id, required this.title});

  Rank.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(id: json.id, title: json['title'].toString());

  static const empty = Rank(id: '', title: '');
}
