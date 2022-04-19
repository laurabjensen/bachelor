import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/leader/components/button_row.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';

class ApproveFriendWidget extends StatelessWidget {
  final UserProfile userProfile;
  final Function() onAcceptFriend;
  final Function() onRejectFriend;

  const ApproveFriendWidget(
      {Key? key,
      required this.userProfile,
      required this.onAcceptFriend,
      required this.onRejectFriend})
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 290,
          width: 336,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profil
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => pushNewScreen(context,
                              screen: ProfileScreen(userProfile: userProfile), withNavBar: false),
                          child: Stack(
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
                                left: 0,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: Image.network(userProfile.rank.imageUrl).image)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(userProfile.name,
                            style: theme.primaryTextTheme.headline3!
                                .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(userProfile.rank.title,
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(color: Colors.black, fontSize: 18)),
                        Text(userProfile.group.name,
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(color: Colors.black, fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),

              Text(
                'Vil gerne være spejderveninde med dig!',
                style: theme.primaryTextTheme.headline3!.copyWith(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              // Annuller
              ApproveBadgeButtonRow(
                onAccept: onAcceptFriend,
                onDeny: onRejectFriend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
