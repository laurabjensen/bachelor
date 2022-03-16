import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class FriendsTab extends StatelessWidget {
  final List<UserProfile> friends;
  final UserProfile userProfile;

  const FriendsTab({Key? key, required this.friends, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget getChallengeBadges() {
      if (friends.isNotEmpty) {
        return ListView(
          physics:
              NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: GridView.count(
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: List.generate(friends.length, (index) {
                      return ProfileFriendWidget(
                        //badge: friends[index],
                        userProfile: userProfile,
                      );
                    }))),
          ],
        );
      }
      return Container();
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [getChallengeBadges()],
        ));
  }
}
