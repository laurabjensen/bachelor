import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:collection/collection.dart';

class BadgeInfoWidget extends StatelessWidget {
  final BadgeSpecific badgeSpecific;
  final List<BadgeRegistration> badgeRegistrations;

  const BadgeInfoWidget({Key? key, required this.badgeSpecific, required this.badgeRegistrations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget status() {
      var registration =
          badgeRegistrations.firstWhereOrNull((element) => element.badgeSpecific == badgeSpecific);
      if (registration != null) {
        return Column(
          children: [
            Text(registration.waitingOnLeader
                ? 'Venter på godkendelse fra leder'
                : registration.denied
                    ? 'Mærke afvist'
                    : 'Du har taget mærket'),
            (!registration.waitingOnLeader && !registration.denied)
                ? Text(registration.date.toString())
                : Container()
          ],
        );
      }
      return Container();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 170,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: Image.network(badgeSpecific.imageUrl).image),
            ),
          ),
        ),
        Text(badgeSpecific.badge.name,
            style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 25)),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(badgeSpecific.getRank(), style: theme.primaryTextTheme.headline1),
        ),
        status()
      ],
    );
  }
}
