import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spejder_app/extensions.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/screens/leader/components/button_row.dart';

class ApproveBadgeWidget extends StatelessWidget {
  final BadgeRegistration badgeRegistration;
  final Function() onAccept;
  final Function() onDeny;

  const ApproveBadgeWidget(
      {Key? key, required this.badgeRegistration, required this.onAccept, required this.onDeny})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 280,
          width: 336,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge + name
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Badge
                    SizedBox(
                      height: 168,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      Image.network(badgeRegistration.badgeSpecific.imageUrl).image,
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Flexible(
                            child: Text(badgeRegistration.badgeSpecific.badge.name,
                                textAlign: TextAlign.center,
                                style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 22)),
                          ),
                          Text(badgeRegistration.badgeSpecific.rank.title.capitalize(),
                              style: theme.primaryTextTheme.headline1!
                                  .copyWith(color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ),
                    // Profile
                    SizedBox(
                      height: 168,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff037B55),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                left: 4,
                                child: SvgPicture.asset(
                                  'assets/tørklæde_rød.svg',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Text(badgeRegistration.userProfile.name,
                                textAlign: TextAlign.center,
                                style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 22)),
                          ),
                          Text(badgeRegistration.userProfile.rank.title,
                              style: theme.primaryTextTheme.headline1!
                                  .copyWith(color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Date
              Text(
                'Har taget mærket: ${DateFormat.d().format(badgeRegistration.date)}. ${DateFormat.MMMM('da').format(badgeRegistration.date)} ${DateFormat.y().format(badgeRegistration.date)}',
                style: theme.primaryTextTheme.headline3!.copyWith(
                  fontSize: 18,
                ),
              ),
              // Approve / Deny
              ApproveBadgeButtonRow(
                onAccept: onAccept,
                onDeny: onDeny,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
