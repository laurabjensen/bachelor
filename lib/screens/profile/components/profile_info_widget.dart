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
          padding: const EdgeInsets.all(8.0),
          child: Text(userProfile.name, style: theme.primaryTextTheme.headline1),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${userProfile.group.name} Gruppe', style: theme.primaryTextTheme.headline2),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userProfile.rank.title,
            style: theme.primaryTextTheme.headline2,
          ),
        ),
      ],
    );
  }
}
