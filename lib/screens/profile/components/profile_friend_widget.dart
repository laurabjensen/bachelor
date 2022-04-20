import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';

class ProfileFriendWidget extends StatelessWidget {
  final UserProfile userProfile;
  final Function()? secondaryOnTap;

  const ProfileFriendWidget({Key? key, required this.userProfile, this.secondaryOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget noImageWidget() {
      return Stack(
        children: [
          Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xffFED105),
              )),
          Positioned(
              left: 3.5,
              top: 5,
              child: SvgPicture.asset(
                'assets/tørklæde_rød.svg',
                height: 80,
                width: 80,
                fit: BoxFit.scaleDown,
              )),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        if (secondaryOnTap == null) {
          pushNewScreen(context,
              screen: ProfileScreen(userProfile: userProfile), withNavBar: false);
        } else {
          secondaryOnTap!();
        }
      },
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
              Stack(
                children: [
                  userProfile.imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            userProfile.imageUrl,
                            width: 90,
                            height: 90,
                            fit: BoxFit.fitHeight,
                          ))
                      : noImageWidget(),
                  // Range picture
                  Positioned(
                    top: 60,
                    right: 65,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                          image: DecorationImage(
                              image: Image.network(userProfile.rank.imageUrl).image)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userProfile.name,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
