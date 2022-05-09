import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_widget.dart';
import 'package:spejder_app/screens/badges/components/description_badge_panel_widget.dart';

class BadgePanelList extends StatelessWidget {
  final BadgeSpecific badgeSpecific;
  final bool isLeader;
  final BadgeRegistration? registration;
  final Function(String text) onDescriptionSaved;

  const BadgePanelList(
      {Key? key,
      required this.badgeSpecific,
      required this.isLeader,
      required this.registration,
      required this.onDescriptionSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(18, 16, 18, 16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        badgeSpecific.badge.type == 'Jubilæum'
            ? Container()
            : Column(children: [
                BadgePanelWidget(title: 'Formål', text: badgeSpecific.purpose),
                BadgePanelWidget(title: 'Forudsætninger', text: badgeSpecific.prerequisite),
                isLeader
                    ? BadgePanelWidget(
                        title: 'Forudsætninger - leder', text: badgeSpecific.prerequisiteLeader)
                    : Container(),
                BadgePanelWidget.showList(title: 'Trin', list: badgeSpecific.steps),
                BadgePanelWidget(title: 'Udfordring', text: badgeSpecific.challenge),
              ]),
        (registration != null && registration!.getStatus() == BadgeRegistrationStatus.accepted)
            ? DescriptionBadgePanelWidget(
                //TODO! Gør det muligt at opdatere
                title: 'Din beskrivelse',
                text: registration?.description,
                onDescriptionSaved: (text) => onDescriptionSaved(text),
              )
            : Container(),
      ],
    );
  }
}
