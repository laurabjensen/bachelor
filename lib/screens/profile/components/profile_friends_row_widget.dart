import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class ProfileFriendsRow extends StatelessWidget {
  final Function() onSeeAll;
  final String headlineText;
  final String noObjectsText;
  final List<Object> objects;

  const ProfileFriendsRow({
    required this.onSeeAll,
    required this.headlineText,
    required this.noObjectsText,
    required this.objects,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
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
                  child: Text('Se alle', style: theme.primaryTextTheme.headline2),
                ),
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
                        itemBuilder: (BuildContext context, int index) => ProfileFriendWidget(
                          userProfile: objects[index] as UserProfile,
                        ),
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
