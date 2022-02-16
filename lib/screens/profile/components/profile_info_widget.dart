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
    return Column(
      children: [
        ProfileImageWidget(
          userProfile: userProfile,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(userProfile.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${userProfile.group.name} Gruppe',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userProfile.rank.title,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
