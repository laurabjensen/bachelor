import 'package:flutter/material.dart';

import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_img_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileInfoWidget({
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ProfileImageWidget(
          userProfile: userProfile,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Text(userProfile.name, style: theme.primaryTextTheme.headline1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${userProfile.group.name} \n',
                textAlign: TextAlign.center, style: theme.primaryTextTheme.headline2),
            SizedBox(
              width: 20,
            ),
            Text(
              '${userProfile.rank.title} \n',
              style: theme.primaryTextTheme.headline2,
            ),
          ],
        ),
      ],
    );
  }
}
