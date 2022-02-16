import 'package:flutter/material.dart';

import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';

class ProfileBadgeWidget extends StatelessWidget {
  final Badge badge;

  const ProfileBadgeWidget({Key? key, required this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecorationImage? getImage() {
      return DecorationImage(
        image: Image.network(
          badge.imageUrlL1,
        ).image,
      );
      /*switch (userProfile.rank.title) {
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
      }*/
    }

    return Card(
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
              )
            ],
          ),
        ));
  }
}
