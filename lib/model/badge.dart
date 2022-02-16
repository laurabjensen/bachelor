import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Badge {
  //! TODO: overvej hvordan vi gemmer brugerens beskrivelse til hvert mærke
  final String id;
  final String name;
  final String purpose;
  final String? imgUrl;
  final String type;

  const Badge(
      {required this.id,
      required this.name,
      required this.purpose,
      required this.type,
      this.imgUrl});

  Badge copyWith({
    String? id,
    String? name,
    String? purpose,
    String? type,
    String? imgUrl,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      purpose: purpose ?? this.purpose,
      type: type ?? this.type,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'purpose': purpose,
      'type': type,
      'imgUrl': imgUrl,
    };
  }

  Badge.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            name: json.get('name'),
            purpose: json.get('purpose'),
            type: json.get('type'),
            imgUrl: json.get('imgUrl'));

  String toJson() => json.encode(toMap());
}
