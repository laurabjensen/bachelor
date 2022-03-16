import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/friends/friends_activity/regret_button_row.dart';
import 'package:spejder_app/screens/leader/components/button_row.dart';

class ApproveFriendWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ApproveFriendWidget({Key? key, required this.userProfile})
      : super(key: key);

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
                          Stack(
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
                          Text(userProfile.name,
                              style: theme.primaryTextTheme.headline3!
                                  .copyWith(fontSize: 22)),
                          Text(userProfile.rank.title,
                              style: theme.primaryTextTheme.headline1!
                                  .copyWith(color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
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
                onAccept: () => null,
                onDeny: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
