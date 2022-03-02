import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';
import 'package:spejder_app/screens/badges/components/badge_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_badge_widget.dart';

class BadgeRow extends StatelessWidget {
  final Badge badge;

  const BadgeRow({Key? key, required this.badge}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: GridView.count(
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: List.generate(4, (index) {
              return BadgeWidget(badge: badge, index: index, onTap: () => null);
            })));
  }
}
