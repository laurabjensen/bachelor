import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spejder_app/model/badge_specific.dart';

class Badge {
  final String id;
  final String name;
  final String type;
  final List<BadgeSpecific> levels;

  const Badge({required this.id, required this.name, required this.type, required this.levels});

  Badge copyWith({
    String? id,
    String? name,
    String? type,
    List<BadgeSpecific>? levels,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      levels: levels ?? this.levels,
    );
  }

  Badge.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(id: json.id, name: json['name'] ?? '', type: json['type'] ?? '', levels: []);

  static const empty = Badge(id: '', name: '', type: '', levels: []);
}
