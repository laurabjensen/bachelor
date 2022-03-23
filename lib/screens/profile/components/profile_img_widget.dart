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
                        // Remember to also update changes fx color -  if made - for the friends row
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xffFED105),
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
              left: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //Silver inner star
                  ClipRect(
                    child: SvgPicture.asset(
                      'assets/star.svg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.fill,
                      color: Color(0xffC0C0C0),
                    ),
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
