import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';

class BadgesTab extends StatelessWidget {
  final List<Badge> challengeBadges;
  final List<Badge> engagementBadges;

  const BadgesTab({Key? key, required this.challengeBadges, required this.engagementBadges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(challengeBadges.length, (index) {
                  return BadgeWidget(badge: challengeBadges[index]);
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
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(engagementBadges.length, (index) {
                  return BadgeWidget(badge: engagementBadges[index]);
                }))
          ],
        );
      }
      return Container();
    }

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [getChallengeBadges(), getEngagementBadges()],
        ));
  }
}
