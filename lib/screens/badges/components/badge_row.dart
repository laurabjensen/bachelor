import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/screens/badges/components/badge_widget.dart';

class BadgeRow extends StatelessWidget {
  final Badge badge;
  final Function(BadgeSpecific) onChange;
  final List<BadgeRegistration>? registrationList;
  final BadgeSpecific selectedBadge;

  const BadgeRow(
      {Key? key,
      required this.badge,
      required this.onChange,
      required this.registrationList,
      required this.selectedBadge})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(4, (index) {
              return BadgeWidget(
                  badge: badge,
                  index: index,
                  onTap: onChange,
                  registrationList: registrationList,
                  selectedBadge: selectedBadge);
            })));
  }
}
