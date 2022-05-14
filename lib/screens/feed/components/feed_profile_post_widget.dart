import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';

class FeedProfileWidget extends StatelessWidget {
  final UserProfile userProfile;

  const FeedProfileWidget({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget noImageWidget() {
      return Stack(
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xffFED105),
              )),
          Positioned(
              left: 3.5,
              top: 5,
              child: SvgPicture.asset(
                'assets/tørklæde_rød.svg',
                height: 40,
                width: 40,
                fit: BoxFit.scaleDown,
              )),
        ],
      );
    }

    return GestureDetector(
      onTap: () => pushNewScreen(context,
          screen: ProfileScreen(userProfile: userProfile), withNavBar: false),
      child: Stack(
        children: [
          userProfile.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userProfile.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  ))
              : noImageWidget(),
          // Range picture
          Positioned(
            top: 30,
            left: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                  image: DecorationImage(image: Image.network(userProfile.rank.imageUrl).image)),
            ),
          ),
        ],
      ),
    );
  }
}
