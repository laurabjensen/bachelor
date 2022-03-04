import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';

class ProfileBadgeWidget extends StatelessWidget {
  final Badge badge;
  //! TODO Dette skal ændres. Ligenu viser den farven på mærket baseret på hvad brugerens rang er.
  //Men Hvis personen har taget et mærke ved et lavere rang bliver dette ikke vist
  final UserProfile userProfile;

  const ProfileBadgeWidget({Key? key, required this.badge, required this.userProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    DecorationImage? getImage() {
      switch (userProfile.rank.title) {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Color(0xffEEF2F3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(image: getImage()),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                badge.name,
                style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
