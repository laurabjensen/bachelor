import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/badges/specific_badge_screen.dart';

class ProfileBadgeWidget extends StatelessWidget {
  final BadgeRegistration badgeRegistration;
  final Rank rank;
  final UserProfile userProfile;

  const ProfileBadgeWidget(
      {Key? key, required this.badgeRegistration, required this.rank, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badge = GetIt.instance
        .get<List<Badge>>()
        .firstWhere((element) => element.id == badgeRegistration.badgeSpecific.badge.id);

    return GestureDetector(
      onTap:
          () => /*pushNewScreen(context,
          screen: SpecificBadgeScreen(userProfile: userProfile, badge: badge), withNavBar: false),*/
              null,
      child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.network(badgeRegistration.badgeSpecific.imageUrl).image)),
                ),
                Text(
                  badgeRegistration.badgeSpecific.badge.name,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.headline3,
                )
              ],
            ),
          )),
    );
  }
}
