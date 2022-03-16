import 'package:flutter/material.dart';

import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';

class ProfileBadgeWidget extends StatelessWidget {
  final Badge badge;
  final Rank rank;

  const ProfileBadgeWidget({Key? key, required this.badge, required this.rank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    DecorationImage? getImage() {
      switch (rank.title) {
        case 'Spire':
          return DecorationImage(image: Image.network(badge.levels[0].imageUrl).image);
        case 'Smutte':
          return DecorationImage(image: Image.network(badge.levels[1].imageUrl).image);
        case 'Spejder':
          return DecorationImage(image: Image.network(badge.levels[2].imageUrl).image);
        case 'Seniorspejder':
        default:
          return DecorationImage(image: Image.network(badge.levels[3].imageUrl).image);
      }
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.specificBadgeScreen, arguments: badge),
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
                  decoration: BoxDecoration(image: getImage()),
                ),
                Text(
                  badge.name,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.headline3,
                )
              ],
            ),
          )),
    );
  }
}
