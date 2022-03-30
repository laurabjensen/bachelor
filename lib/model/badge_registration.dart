import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';

enum BadgeRegistrationStatus { waitingOnLeader, denied, accepted }

class BadgeRegistration {
  final String id;
  final BadgeSpecific badgeSpecific;
  final String userProfileId;
  final UserProfile? userProfile; //Brug til at få alt info om useren
  final String leader;
  final DateTime date;
  final String description;
  final bool waitingOnLeader;
  final bool denied;
  final DateTime? approvedAt;

  BadgeRegistration(
      {required this.id,
      required this.badgeSpecific,
      required this.userProfileId,
      this.userProfile,
      required this.leader,
      required this.date,
      required this.description,
      required this.waitingOnLeader,
      required this.denied,
      this.approvedAt});

  BadgeRegistration copyWith(
      {String? id,
      BadgeSpecific? badgeSpecific,
      String? userProfileId,
      UserProfile? userProfile,
      String? leader,
      DateTime? date,
      String? description,
      bool? waitingOnLeader,
      bool? denied,
      DateTime? approvedAt}) {
    return BadgeRegistration(
        id: id ?? this.id,
        badgeSpecific: badgeSpecific ?? this.badgeSpecific,
        userProfileId: userProfileId ?? this.userProfileId,
        userProfile: userProfile ?? this.userProfile,
        leader: leader ?? this.leader,
        date: date ?? this.date,
        description: description ?? this.description,
        waitingOnLeader: waitingOnLeader ?? this.waitingOnLeader,
        denied: denied ?? this.denied,
        approvedAt: approvedAt ?? this.approvedAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'badge': badgeSpecific.badge.id,
      'rank': badgeSpecific.rank.id,
      'user': userProfileId,
      'leader': leader,
      'date': Timestamp.fromDate(date),
      'description': description,
      'waitingOnLeader': waitingOnLeader,
      'denied': denied,
      'approvedAt': approvedAt
    };
  }

  BadgeRegistration.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            badgeSpecific: BadgeSpecific.empty,
            userProfileId: json.get('user'),
            leader: json.get('leader'),
            date: (json.get('date') as Timestamp).toDate(),
            description: json.get('description'),
            waitingOnLeader: json.get('waitingOnLeader'),
            denied: json.get('denied'),
            approvedAt: json.get('approvedAt') != null
                ? (json.get('approvedAt') as Timestamp).toDate()
                : json.get('approvedAt'));

  BadgeRegistrationStatus getStatus() {
    if (waitingOnLeader) return BadgeRegistrationStatus.waitingOnLeader;
    if (denied) return BadgeRegistrationStatus.denied;
    return BadgeRegistrationStatus.accepted;
  }
}
