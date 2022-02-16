import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';

class BadgeWidget extends StatelessWidget {
  final Badge badge;
  //! TODO Dette skal ændres. Ligenu viser den farven på mærket baseret på hvad brugerens rang er.
  //Men Hvis personen har taget et mærke ved et lavere rang bliver dette ikke vist
  final UserProfile userProfile;

  const BadgeWidget({Key? key, required this.badge, required this.userProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DecorationImage? getImage() {
      switch (userProfile.rank.title) {
        case 'Spire':
          return DecorationImage(image: Image.network(badge.imageUrlL1).image);
        case 'Smutte':
          return DecorationImage(image: Image.network(badge.imageUrlL2).image);
        case 'Spejder':
          return DecorationImage(image: Image.network(badge.imageUrlL3).image);
        case 'Seniorspejder':
          return DecorationImage(image: Image.network(badge.imageUrlL4).image);
        default:
          return null;
      }
    }

    return Card(
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
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
