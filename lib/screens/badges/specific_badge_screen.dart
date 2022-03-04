import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/components/badge_info_widget.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_list.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_widget.dart';
import 'package:spejder_app/screens/badges/components/badge_row.dart';
import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecificBadgeScreen extends StatefulWidget {
  final Badge badge;

  const SpecificBadgeScreen({Key? key, required this.badge}) : super(key: key);
  @override
  _SpecificBadgeScreenState createState() => _SpecificBadgeScreenState();
}

class _SpecificBadgeScreenState extends State<SpecificBadgeScreen> {
  late ValueNotifier<BadgeSpecific> badgeSpecific;
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    badgeSpecific = ValueNotifier<BadgeSpecific>(widget.badge.levels.firstWhere((element) {
      if (userProfile.rank.title == 'Leder') {
        return element.rank == 'seniorspejder';
      } else {
        return element.rank ==
            BlocProvider.of<AuthenticationBloc>(context)
                .state
                .userProfile!
                .rank
                .title
                .toLowerCase();
      }
    }));
  }

  void openUrl() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'https',
      path: badgeSpecific.value.link.replaceFirst('https://', ''),
    );
    launch(emailLaunchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable: badgeSpecific,
        builder: (context, BadgeSpecific value, child) {
          return Scaffold(
            backgroundColor: Color(0xff63A288),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BadgeInfoWidget(badgeSpecific: value),
                  BadgeRow(
                      badge: widget.badge,
                      onChange: (newBadgeSpecific) {
                        badgeSpecific.value = newBadgeSpecific;
                      }),
                  BadgePanelList(
                    badgeSpecific: badgeSpecific.value,
                    isLeader: userProfile.rank.title == 'Leder',
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 170,
                      height: 51,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.registerBadgeScreen,
                            arguments: value),
                        style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                        child: Text(
                          'Registrer mærke',
                          style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  // Læs mere button med icon
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Center(
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.link,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        label: Text(
                          'Læs mere',
                          style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                        ),
                        onPressed: () => openUrl(),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffACC6B1),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
