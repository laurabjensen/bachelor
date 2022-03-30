import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';
import 'package:spejder_app/screens/badges/bloc/badges_bloc.dart';
import 'package:spejder_app/screens/badges/specific_badge_screen.dart';

class BadgesTab extends StatelessWidget {
  final BadgesStateStatus status;
  final List<Object> challengeBadges;
  final List<Object> engagementBadges;
  final UserProfile userProfile;

  const BadgesTab(
      {Key? key,
      required this.status,
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
                  return ProfileBadgeWidget(
                    badge: challengeBadges is List<Badge> ? challengeBadges[index] as Badge : null,
                    badgeRegistration: challengeBadges is List<BadgeRegistration>
                        ? challengeBadges[index] as BadgeRegistration
                        : null,
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
                  return ProfileBadgeWidget(
                    badge:
                        engagementBadges is List<Badge> ? engagementBadges[index] as Badge : null,
                    badgeRegistration: engagementBadges is List<BadgeRegistration>
                        ? engagementBadges[index] as BadgeRegistration
                        : null,
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
        // If badges are not yet loaded show an animation to the user
        child: status == BadgesStateStatus.loading &&
                challengeBadges.isEmpty &&
                engagementBadges.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [getChallengeBadges(), getEngagementBadges()],
              ));
  }
}
