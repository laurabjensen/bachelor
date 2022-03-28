import 'package:flutter/material.dart';

import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_description_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_img_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileInfoWidget({
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Text text(String text) {
      return Text(text, style: theme.primaryTextTheme.headline1);
    }

    return Column(children: [
      Row(
        children: [
          ProfileImageWidget(
            userProfile: userProfile,
          ),
          Flexible(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('${userProfile.badgeRegistrations.length}',
                          style: theme.primaryTextTheme.headline1!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(userProfile.badgeCase(),
                          style: theme.primaryTextTheme.headline1)
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text('${userProfile.friends.length}',
                          style: theme.primaryTextTheme.headline1!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(userProfile.friendsCase(),
                          style: theme.primaryTextTheme.headline1)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Text(
                    '${userProfile.group.name} gruppe',
                    style: theme.primaryTextTheme.headline2!
                        .copyWith(fontSize: 17),
                    textAlign: TextAlign.center,
                  )),
                  Text(userProfile.rank.title,
                      style: theme.primaryTextTheme.headline2!
                          .copyWith(fontSize: 17))
                ],
              )
            ],
          )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      ProfileDescriptionWidget(
        userProfile: userProfile,
      ),
    ]);
  }
}
