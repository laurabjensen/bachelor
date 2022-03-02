import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_badge_widget.dart';

class ProfileBadgesRow extends StatelessWidget {
  final Function() onSeeAll;
  final String headlineText;
  final String noObjectsText;
  final List<Object> objects;
  final UserProfile userProfile;

  const ProfileBadgesRow(
      {required this.onSeeAll,
      required this.objects,
      required this.headlineText,
      required this.noObjectsText,
      required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headlineText,
                  style: theme.primaryTextTheme.headline1,
                ),
                GestureDetector(
                    onTap: onSeeAll,
                    child: Text('Se alle', style: theme.primaryTextTheme.headline2)),
              ],
            ),
            objects.isNotEmpty
                ? SizedBox(
                    height: 135,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: objects.length,
                        itemBuilder: (BuildContext context, int index) => ProfileBadgeWidget(
                            badge: objects[index] as Badge, rank: userProfile.rank),
                      ),
                    ))
                : SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(noObjectsText, style: theme.primaryTextTheme.bodyText2),
                    ))
          ],
        ));
  }
}
