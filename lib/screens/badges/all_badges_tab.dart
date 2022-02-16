import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';

class BadgesTab extends StatelessWidget {
  final List<Badge> challengeBadges;
  final List<Badge> engagementBadges;
  final UserProfile userProfile;

  const BadgesTab(
      {Key? key,
      required this.challengeBadges,
      required this.engagementBadges,
      required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget getChallengeBadges() {
      if (challengeBadges.isNotEmpty) {
        return ListView(
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Udfordringsmærker',
                style: theme.primaryTextTheme.headline1,
              ),
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: List.generate(challengeBadges.length, (index) {
                  return BadgeWidget(
                    badge: challengeBadges[index],
                    userProfile: userProfile,
                  );
                }))
          ],
        );
      }
      return Container();
    }

    Widget getEngagementBadges() {
      if (engagementBadges.isNotEmpty) {
        return ListView(
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Engagementsmærker',
                style: theme.primaryTextTheme.headline1,
              ),
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: List.generate(engagementBadges.length, (index) {
                  return BadgeWidget(
                    badge: engagementBadges[index],
                    userProfile: userProfile,
                  );
                }))
          ],
        );
      }
      return Container();
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [getChallengeBadges(), getEngagementBadges()],
        ));
  }
}
