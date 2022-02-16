import 'package:cloud_firestore/cloud_firestore.dart';

class Rank {
  final String id;
  final String title;
  final String imageUrl;

  const Rank({required this.id, required this.title, required this.imageUrl});

  Rank.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(id: json.id, title: json.get('title'), imageUrl: json.get('imageUrl'));

  static const empty = Rank(id: '', title: '', imageUrl: '');
}
