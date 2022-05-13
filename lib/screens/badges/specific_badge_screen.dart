import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/badge_users_screen.dart';
import 'package:spejder_app/screens/badges/bloc/badges_bloc.dart';
import 'package:spejder_app/screens/badges/components/badge_info_widget.dart';
import 'package:spejder_app/screens/badges/components/badge_panel_list.dart';
import 'package:spejder_app/screens/badges/components/badge_row.dart';
import 'package:spejder_app/screens/badges/registration/components/read_more_button.dart';
import 'package:spejder_app/screens/badges/registration/register_badge_screen.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:collection/collection.dart';

class SpecificBadgeScreen extends StatefulWidget {
  final UserProfile userProfile;
  final Badge badge;
  final BadgesBloc badgesBloc;

  const SpecificBadgeScreen(
      {Key? key, required this.userProfile, required this.badge, required this.badgesBloc})
      : super(key: key);
  @override
  _SpecificBadgeScreenState createState() => _SpecificBadgeScreenState();
}

class _SpecificBadgeScreenState extends State<SpecificBadgeScreen> {
  late Badge badge;
  late ValueNotifier<BadgeSpecific> badgeSpecific;
  late UserProfile loggedInUser;

  @override
  void initState() {
    super.initState();

    badge = widget.badge;
    if (widget.badge.levels.isEmpty) {
      badge = GetIt.instance.get<List<Badge>>().firstWhere((element) => element.id == badge.id);
    }
    loggedInUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    badgeSpecific = ValueNotifier<BadgeSpecific>(badge.levels.firstWhere((element) {
      if (widget.userProfile.rank.title == 'Leder') {
        return element.rank.title == 'Seniorspejder';
      } else {
        return element.rank.title ==
            BlocProvider.of<AuthenticationBloc>(context).state.userProfile!.rank.title;
      }
    }));
  }

  /* Register button only shows is you have the correct level
   and have been denied or not yet registered the badge */
  Widget getButton(BadgeRegistration? registration, BadgeSpecific value, ThemeData theme) {
    if (registration != null) {
      if (registration.getStatus() == BadgeRegistrationStatus.waitingOnLeader ||
          registration.getStatus() == BadgeRegistrationStatus.accepted) {
        return Container();
      }
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        width: 170,
        height: 51,
        child: ElevatedButton(
          onPressed: () => pushNewScreen(context,
                  screen: RegisterBadgeScreen(badgeSpecific: value), withNavBar: false)
              .then((value) => (value as bool) ? widget.badgesBloc.add(LoadUserBadges()) : null),
          style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
          child: Text(
            'Registrer mærke',
            style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
          ),
        ),
      ),
    );
  }

  //TODO! Change futurebuilder to bloc and call a function in init state to load registrations
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
        onWillPop: () async {
          widget.badgesBloc.state.isEditing ? widget.badgesBloc.add(EditingToggled()) : null;
          return true;
        },
        child: BlocProvider.value(
          value: widget.badgesBloc,
          child: BlocBuilder(
              bloc: widget.badgesBloc,
              builder: (context, BadgesState state) {
                if (state.badgesStatus == BadgesStateStatus.loaded) {
                  return ValueListenableBuilder(
                      valueListenable: badgeSpecific,
                      builder: (context, BadgeSpecific value, child) {
                        var registration = state.registrations.firstWhereOrNull(
                            (element) => element.badgeSpecific == badgeSpecific.value);
                        return CustomScaffold(
                          appBar: CustomAppBar.basicAppBarWithBackButton(
                              title: badge.name,
                              onBack: () {
                                Navigator.pop(context);
                                widget.badgesBloc.state.isEditing
                                    ? widget.badgesBloc.add(EditingToggled())
                                    : null;
                              },
                              actions: [
                                IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: () {
                                      widget.badgesBloc.add(LoadPeopleForBadgeSpecific(value));
                                      pushNewScreen(context,
                                          screen: BadgeUsersScreen(
                                              badgesBloc: widget.badgesBloc, badgeSpecific: value));
                                    })
                              ]),
                          body: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BadgeInfoWidget(
                                  badgeSpecific: value,
                                  registration: registration,
                                ),
                                BadgeRow(
                                  badge: badge,
                                  onChange: (newBadgeSpecific) {
                                    badgeSpecific.value = newBadgeSpecific;
                                  },
                                  registrationList: state.registrations,
                                  selectedBadge: badgeSpecific.value,
                                ),
                                BadgePanelList(
                                  badgeSpecific: badgeSpecific.value,
                                  isLeader: widget.userProfile.rank.title == 'Leder',
                                  registration: registration,
                                  onDescriptionSaved: (text) => widget.badgesBloc
                                      .add(DescriptionUpdated(registration!, text)),
                                ),
                                getButton(registration, value, theme),
                                // Læs mere button med icon
                                ReadMoreButton(
                                  badgeSpecific: badgeSpecific.value,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return CustomScaffold(
                    appBar: CustomAppBar.basicAppBarWithBackButton(
                        title: badge.name,
                        onBack: () {
                          Navigator.pop(context);
                          widget.badgesBloc.state.isEditing
                              ? widget.badgesBloc.add(EditingToggled())
                              : null;
                        }),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ));
  }
}
