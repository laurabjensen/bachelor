import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_widget.dart';

class BadgePanelList extends StatelessWidget {
  final BadgeSpecific badgeSpecific;
  final bool isLeader;
  final BadgeRegistration? registration;

  const BadgePanelList(
      {Key? key, required this.badgeSpecific, required this.isLeader, required this.registration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: EdgeInsets.fromLTRB(18, 16, 18, 16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        BadgePanelWidget(title: 'Formål', text: badgeSpecific.purpose),
        BadgePanelWidget(title: 'Forudsætninger', text: badgeSpecific.prerequisite),
        isLeader
            ? BadgePanelWidget(
                title: 'Forudsætninger - leder', text: badgeSpecific.prerequisiteLeader)
            : Container(),
        BadgePanelWidget.showList(title: 'Trin', list: badgeSpecific.steps),
        BadgePanelWidget(title: 'Udfordring', text: badgeSpecific.challenge),
        (registration != null && registration!.getStatus() == BadgeRegistrationStatus.accepted)
            ? BadgePanelWidget(
                title: 'Din beskrivelse',
                text: registration!.description.isNotEmpty
                    ? registration!.description
                    : 'Ingen beskrivelse givet.')
            : Container(),
      ],
    );
  }
}
