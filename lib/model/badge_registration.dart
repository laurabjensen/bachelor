import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';

enum BadgeRegistrationStatus { waitingOnLeader, denied, accepted }

class BadgeRegistration {
  final String id;
  final BadgeSpecific badgeSpecific;
  final UserProfile userProfile;
  final UserProfile leader;
  final DateTime date;
  final String description;
  final bool waitingOnLeader;
  final bool denied;

  BadgeRegistration(
      {required this.id,
      required this.badgeSpecific,
      required this.userProfile,
      required this.leader,
      required this.date,
      required this.description,
      required this.waitingOnLeader,
      required this.denied});

  BadgeRegistration copyWith(
      {String? id,
      BadgeSpecific? badgeSpecific,
      UserProfile? userProfile,
      UserProfile? leader,
      DateTime? date,
      String? description,
      bool? waitingOnLeader,
      bool? denied}) {
    return BadgeRegistration(
        id: id ?? this.id,
        badgeSpecific: badgeSpecific ?? this.badgeSpecific,
        userProfile: userProfile ?? this.userProfile,
        leader: leader ?? this.leader,
        date: date ?? this.date,
        description: description ?? this.description,
        waitingOnLeader: waitingOnLeader ?? this.waitingOnLeader,
        denied: denied ?? this.denied);
  }

  Map<String, dynamic> toMap() {
    return {
      'badge': badgeSpecific.badge.id,
      'rank': badgeSpecific.rank.id,
      'user': userProfile.id,
      'leader': leader.id,
      'date': Timestamp.fromDate(date),
      'description': description,
      'waitingOnLeader': waitingOnLeader,
      'denied': denied
    };
  }

  BadgeRegistration.fromJson(DocumentSnapshot<Map<String, Object?>> json)
      : this(
            id: json.id,
            badgeSpecific: BadgeSpecific.empty,
            userProfile: UserProfile.empty,
            leader: UserProfile.empty,
            date: (json.get('date') as Timestamp).toDate(),
            description: json.get('description'),
            waitingOnLeader: json.get('waitingOnLeader'),
            denied: json.get('denied'));

  BadgeRegistrationStatus getStatus() {
    if (waitingOnLeader) return BadgeRegistrationStatus.waitingOnLeader;
    if (denied) return BadgeRegistrationStatus.denied;
    return BadgeRegistrationStatus.accepted;
  }
}
