import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spejder_app/extensions.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:collection/collection.dart';
import 'package:spejder_app/screens/badges/registration/bloc/badge_registration_bloc.dart';

class BadgeInfoWidget extends StatelessWidget {
  final BadgeSpecific badgeSpecific;
  final BadgeRegistration? registration;

  const BadgeInfoWidget({Key? key, required this.badgeSpecific, this.registration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget status() {
      if (registration != null) {
        String text() {
          switch (registration!.getStatus()) {
            case BadgeRegistrationStatus.accepted:
              return 'Du har taget mærket';
            case BadgeRegistrationStatus.waitingOnLeader:
              return 'Venter på godkendelse fra leder';
            case BadgeRegistrationStatus.denied:
              return 'Mærke afvist';
          }
        }

        return Column(
          children: [
            Text(
              text(),
              style: theme.primaryTextTheme.headline2!.copyWith(
                fontSize: 16,
              ),
            ),
            (registration!.getStatus() == BadgeRegistrationStatus.accepted)
                ? Text(
                    'D. ${DateFormat.d().format(registration!.date)}. ${DateFormat.MMMM('da').format(registration!.date)} ${DateFormat.y().format(registration!.date)}',
                    style: theme.primaryTextTheme.headline2!.copyWith(
                      fontSize: 16,
                    ),
                  )
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(badgeSpecific.rank.capitalize(), style: theme.primaryTextTheme.headline1),
        ),
        status()
      ],
    );
  }
}
