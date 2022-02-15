import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';

class AllBadgesTab extends StatelessWidget {
  final List<Badge> badges;

  const AllBadgesTab({Key? key, required this.badges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: List.generate(badges.length, (index) {
            return BadgeWidget(badge: badges[index]);
          })),
    );
  }
}
