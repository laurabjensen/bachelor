import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';

class ProfileImageWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileImageWidget({Key? key, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            // Profile picture circle
            Positioned(
                left: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userProfile.imageUrl,
                    width: 170,
                    height: 170,
                    fit: BoxFit.fitHeight,
                  ),
                )),
            // Range circle
            Positioned(
              top: 120,
              left: 10,
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.network(userProfile.rank.imageUrl).image)),
              ),
            ),
            // Star
            Positioned(
              top: 100,
              left: 135,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 70,
                    color: Color(0xff8d99a3),
                  ),
                  Text(
                    userProfile.seniority.toString(),
                    style: theme.primaryTextTheme.headline3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
