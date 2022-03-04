import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_specific.dart';

class BadgeInfoWidget extends StatelessWidget {
  final BadgeSpecific badgeSpecific;

  const BadgeInfoWidget({Key? key, required this.badgeSpecific}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(badgeSpecific.getRank(), style: theme.primaryTextTheme.headline1),
        ),
      ],
    );
  }
}
