import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Badge {
  //! TODO: overvej hvordan vi gemmer brugerens beskrivelse til hvert mærke
  final String id;
  final String name;
  final String purpose;
  final String type;
  final String imageUrlL1;
  final String imageUrlL2;
  final String imageUrlL3;
  final String imageUrlL4;

  const Badge({
    required this.id,
    required this.name,
    required this.purpose,
    required this.type,
    required this.imageUrlL1,
    required this.imageUrlL2,
    required this.imageUrlL3,
    required this.imageUrlL4,
  });

  Badge copyWith({
    String? id,
    String? name,
    String? purpose,
    String? type,
    String? imageUrlL1,
    String? imageUrlL2,
    String? imageUrlL3,
    String? imageUrlL4,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      purpose: purpose ?? this.purpose,
      type: type ?? this.type,
      imageUrlL1: imageUrlL1 ?? this.imageUrlL1,
      imageUrlL2: imageUrlL2 ?? this.imageUrlL2,
      imageUrlL3: imageUrlL3 ?? this.imageUrlL3,
      imageUrlL4: imageUrlL4 ?? this.imageUrlL4,
    );
  }

  Badge.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
          id: json.id,
          name: json.get('name'),
          purpose: json.get('purpose'),
          type: json.get('type'),
          imageUrlL1: json.get('imageUrlL1'),
          imageUrlL2: json.get('imageUrlL2'),
          imageUrlL3: json.get('imageUrlL3'),
          imageUrlL4: json.get('imageUrlL4'),
        );
}
