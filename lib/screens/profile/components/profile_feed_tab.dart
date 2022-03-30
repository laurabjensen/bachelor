import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/feed_widget.dart';

class ProfileFeedTab extends StatelessWidget {
  final List<BadgeRegistration> approvedBadges;
  final UserProfile userProfile;

  const ProfileFeedTab({Key? key, required this.approvedBadges, required this.userProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: approvedBadges.length,
      itemBuilder: (context, index) {
        return FeedWidget(
          userProfile: userProfile,
          registration: approvedBadges[index],
        );
      },
    );
  }
}
