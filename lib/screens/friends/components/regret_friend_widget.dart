import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/friends/friends_activity/regret_button_row.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';

class RegretFriendWidget extends StatelessWidget {
  final UserProfile userProfile;

  const RegretFriendWidget({Key? key, required this.userProfile})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 280,
          width: 336,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profil
              SizedBox(
                height: 168,
                width: 160,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => pushNewScreen(context,
                                screen: ProfileScreen(userProfile: userProfile),
                                withNavBar: false),
                            child: Stack(
                              children: [
                                Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xff037B55),
                                    )),
                                Positioned(
                                    top: 5,
                                    left: 5,
                                    child: SvgPicture.asset(
                                      'assets/tørklæde_rød.svg',
                                      width: 80,
                                      height: 80,
                                    ))
                              ],
                            ),
                          ),
                          Text('Navn',
                              style: theme.primaryTextTheme.headline3!
                                  .copyWith(fontSize: 22)),
                          /*Text(badgeSpecific.getRank(),
                                      style: theme.primaryTextTheme.headline1!
                                          .copyWith(color: Colors.black, fontSize: 18)),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Du har sendt en spejderveninde anmodning som venter på godkendelse',
                style: theme.primaryTextTheme.headline3!.copyWith(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              // Godkend / Afvis
              RegretButtonRow(
                onDeny: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
