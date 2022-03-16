import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spejder_app/model/user_profile.dart';

class ProfileImageWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileImageWidget({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          // Sizedbox laver mellemrum mellem profilbilledewidget og navn
          SizedBox(
        height: 160,
        width: 200,
        child: Stack(
          children: [
            // Profile picture circle
            Positioned(
                left: 25,
                child: userProfile.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          userProfile.imageUrl,
                          width: 150,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ))
                    : Stack(
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff037B55),
                              )),
                          Positioned(
                              left: 15, top: 15, child: SvgPicture.asset('assets/tørklæde_rød.svg'))
                        ],
                      )),
            // Range picture
            Positioned(
              top: 100,
              left: 10,
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                    image: DecorationImage(image: Image.network(userProfile.rank.imageUrl).image)),
              ),
            ),
            // Star
            Positioned(
              top: 100,
              left: 125,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outline border around star
                  Icon(
                    Icons.star,
                    size: 60,
                    color: Color.fromARGB(255, 56, 57, 58),
                  ),
                  // Silver star
                  Icon(
                    Icons.star,
                    size: 55,
                    color: Color(0xff8d99a3),
                  ),
                  // Number of years
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
