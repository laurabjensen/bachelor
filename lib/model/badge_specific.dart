import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge.dart';

class BadgeSpecific {
  final Badge badge;
  final String rank;
  final String purpose;
  final String prerequisite;
  final String prerequisiteLeader;
  final List<String> steps;
  final String challenge;
  final String link;
  final String imageUrl;

  const BadgeSpecific({
    required this.badge,
    required this.rank,
    required this.purpose,
    required this.prerequisite,
    required this.prerequisiteLeader,
    required this.steps,
    required this.challenge,
    required this.link,
    required this.imageUrl,
  });

  BadgeSpecific copyWith({
    Badge? badge,
    String? rank,
    String? purpose,
    String? prerequisite,
    String? prerequisiteLeader,
    List<String>? steps,
    String? challenge,
    String? link,
    String? imageUrl,
  }) {
    return BadgeSpecific(
      badge: badge ?? this.badge,
      rank: rank ?? this.rank,
      purpose: purpose ?? this.purpose,
      prerequisite: prerequisite ?? this.prerequisite,
      prerequisiteLeader: prerequisiteLeader ?? this.prerequisiteLeader,
      steps: steps ?? this.steps,
      challenge: challenge ?? this.challenge,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  BadgeSpecific.fromJson(Badge badge, DocumentSnapshot<Map<String, Object?>> json)
      : this(
          badge: badge,
          rank: json.id,
          purpose: json['purpose'] ?? '',
          prerequisite: json['prerequisite'] ?? '',
          prerequisiteLeader: json['prerequisiteLeader'] ?? '',
          steps: List<String>.from(json['steps']),
          challenge: json['challenge'] ?? '',
          link: json['link'] ?? '',
          imageUrl: json['imageUrl'] ?? '',
        );

  static const empty = BadgeSpecific(
      badge: Badge.empty,
      rank: '',
      purpose: '',
      prerequisite: '',
      prerequisiteLeader: '',
      steps: [],
      challenge: '',
      link: '',
      imageUrl: '');
}
