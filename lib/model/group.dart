import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String id;
  final String name;
  final int zipCode;

  const Group({required this.id, required this.name, required this.zipCode});

  Group.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(id: json.id, name: json['name'].toString(), zipCode: json['zipcode'] as int);

  static const empty = Group(id: '', name: '', zipCode: 0);
}
