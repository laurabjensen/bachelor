import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';
import 'package:spejder_app/screens/badges/bloc/badges_bloc.dart';

class BadgesTab extends StatelessWidget {
  final BadgesStateStatus status;
  final List<Object> challengeBadges;
  final List<Object> engagementBadges;
  final List<Object> jubileeBadges;
  final UserProfile userProfile;

  const BadgesTab(
      {Key? key,
      required this.status,
      required this.challengeBadges,
      required this.engagementBadges,
      required this.jubileeBadges,
      required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    /*Widget getChallengeBadges() {
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
                })),
          ],
        );
      }

      
    }*/

    /*Widget getEngagementBadges() {
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
    }*/

    Widget listView(List<Object> list, String title) {
      if (list.isNotEmpty) {
        return ListView(
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: theme.primaryTextTheme.headline1,
              ),
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: List.generate(list.length, (index) {
                  return ProfileBadgeWidget(
                    badge: list is List<Badge> ? list[index] : null,
                    badgeRegistration: list is List<BadgeRegistration> ? list[index] : null,
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
        child: status == BadgesStateStatus.loading
            ? Center(child: CircularProgressIndicator())
            : (challengeBadges.isEmpty && engagementBadges.isEmpty && jubileeBadges.isEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      heightFactor: 2,
                      child: Text(
                        'Intet at vise',
                        style: Theme.of(context).primaryTextTheme.headline2!.copyWith(fontSize: 16),
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      listView(challengeBadges, 'Udfordringsmærker'),
                      listView(engagementBadges, 'Engagementsmærker'),
                      listView(jubileeBadges, 'Jubilæumsmærker'),
                      //Sizedbox makes sure there is a bit of space in the bottom of the screen,
                      // so badges dont hide behind the navbar
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ));
  }
}
