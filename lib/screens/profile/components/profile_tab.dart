import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class ProfileTab extends StatelessWidget {
  final UserProfile userProfile;
  final List<BadgeRegistration>? approvedBadges;
  final List<UserProfile>? friends;

  const ProfileTab(
      {Key? key,
      required this.userProfile,
      required this.approvedBadges,
      required this.friends})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    approvedBadges?.sort((a, b) =>
        a.badgeSpecific.badge.name.compareTo(b.badgeSpecific.badge.name));

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        physics:
            NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        children: [
          GridView.count(
            physics:
                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            crossAxisCount: 2,
            children: List.generate(
                approvedBadges?.length ?? friends?.length ?? 0, (index) {
              if (approvedBadges != null && approvedBadges!.isNotEmpty) {
                return ProfileBadgeWidget(
                  badge: null,
                  badgeRegistration: approvedBadges![index],
                  userProfile: userProfile,
                );
              } else if (friends != null && friends!.isNotEmpty) {
                return ProfileFriendWidget(
                  userProfile: friends![index],
                );
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }
}
