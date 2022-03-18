import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/rank.dart';

class BadgeSpecific {
  final Badge badge;
  final Rank rank;
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
    Rank? rank,
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

  BadgeSpecific.fromJson(Badge badge, List<Rank> ranks, DocumentSnapshot<Map<String, Object?>> json)
      : this(
          badge: badge,
          rank: ranks.firstWhere((element) => element.id == json.id),
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
      rank: Rank.empty,
      purpose: '',
      prerequisite: '',
      prerequisiteLeader: '',
      steps: [],
      challenge: '',
      link: '',
      imageUrl: '');
}
