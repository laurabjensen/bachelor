import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/components/badge_info_widget.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_list.dart';
import 'package:spejder_app/screens/badges/components/badge_row.dart';
import 'package:spejder_app/screens/badges/registration/components/read_more_button.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:collection/collection.dart';

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
        return element.rank.title == 'Seniorspejder';
      } else {
        return element.rank.title ==
            BlocProvider.of<AuthenticationBloc>(context).state.userProfile!.rank.title;
      }
    }));
  }

  Widget getButton(BadgeRegistration? registration, BadgeSpecific value, ThemeData theme) {
    if (registration != null) {
      if (registration.getStatus() == BadgeRegistrationStatus.waitingOnLeader ||
          registration.getStatus() == BadgeRegistrationStatus.denied ||
          userProfile.rank.level > badgeSpecific.value.rank.level) {
        return Container();
      }
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        width: 170,
        height: 51,
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.registerBadgeScreen, arguments: value),
          style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
          child: Text(
            'Registrer mærke',
            style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
        future: GetIt.instance
            .get<BadgeRegistrationRepository>()
            .getBadgeRegistrationFromBadgeAndUser(widget.badge, userProfile),
        builder: (context, AsyncSnapshot<List<BadgeRegistration>> list) {
          if (list.hasData) {
            return ValueListenableBuilder(
                valueListenable: badgeSpecific,
                builder: (context, BadgeSpecific value, child) {
                  var registration = list.data!
                      .firstWhereOrNull((element) => element.badgeSpecific == badgeSpecific.value);

                  return CustomScaffold(
                    body: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
                      child: CustomNavBar(
                        padding: EdgeInsets.only(left: 10),
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BadgeInfoWidget(
                              badgeSpecific: value,
                              registration: registration,
                            ),
                            BadgeRow(
                              badge: widget.badge,
                              onChange: (newBadgeSpecific) {
                                badgeSpecific.value = newBadgeSpecific;
                              },
                              registrationList: list.data,
                              selectedBadge: badgeSpecific.value,
                            ),
                            BadgePanelList(
                              badgeSpecific: badgeSpecific.value,
                              isLeader: userProfile.rank.title == 'Leder',
                              registration: registration,
                            ),
                            getButton(registration, value, theme),
                            // Læs mere button med icon
                            ReadMoreButton(
                              badgeSpecific: badgeSpecific.value,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return CustomScaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
