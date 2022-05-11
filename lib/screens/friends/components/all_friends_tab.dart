import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class FriendsTab extends StatelessWidget {
  final bool loading;
  final List<UserProfile> friends;
  final UserProfile userProfile;

  const FriendsTab(
      {Key? key, required this.friends, required this.userProfile, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getChallengeBadges() {
      if (friends.isNotEmpty) {
        return ListView(
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: List.generate(friends.length, (index) {
                      return ProfileFriendWidget(
                        //badge: friends[index],
                        userProfile: friends[index],
                      );
                    }))),
          ],
        );
      } else if (loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          heightFactor: 2,
          child: Text(
            'Intet at vise',
            style: Theme.of(context).primaryTextTheme.headline2!.copyWith(fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [getChallengeBadges()],
        ));
  }
}
