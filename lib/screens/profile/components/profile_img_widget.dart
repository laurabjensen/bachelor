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
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            // Profile picture circle
            Positioned(
                left: 15,
                child: userProfile.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          userProfile.imageUrl,
                          width: 170,
                          height: 170,
                          fit: BoxFit.fitHeight,
                        ))
                    : Stack(
                        children: [
                          Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff037B55),
                              )),
                          Positioned(
                              left: 25, top: 25, child: SvgPicture.asset('assets/tørklæde_rød.svg'))
                        ],
                      )),
            // Range picture
            Positioned(
              top: 120,
              left: 10,
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                    image: DecorationImage(image: Image.network(userProfile.rank.imageUrl).image)),
              ),
            ),
            // Star
            Positioned(
              top: 110,
              left: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outline border around star
                  Icon(
                    Icons.star,
                    size: 70,
                    color: Color.fromARGB(255, 56, 57, 58),
                  ),
                  // Silver star
                  Icon(
                    Icons.star,
                    size: 65,
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
