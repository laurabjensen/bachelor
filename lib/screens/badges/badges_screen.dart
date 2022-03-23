import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/all_badges_tab.dart';

import 'bloc/badges_bloc.dart';

class BadgesScreen extends StatefulWidget {
  final Map args;

  const BadgesScreen({Key? key, required this.args}) : super(key: key);
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> with TickerProviderStateMixin {
  late UserProfile userProfile;
  late int initialTabIndex;
  late UserProfile loggedInUser;
  late BadgesBloc badgesBloc;
  late TabController controller;

  @override
  void initState() {
    userProfile = widget.args['userprofile'];
    initialTabIndex = widget.args['initialTabIndex'];
    badgesBloc = BadgesBloc(userProfile: userProfile);
    loggedInUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    controller = TabController(length: 2, vsync: this, initialIndex: initialTabIndex);

    super.initState();
  }

  // TODO! Find ud af hvad vi skal gøre med background svg her!!!
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BadgesBloc, BadgesState>(
      bloc: badgesBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff63A288),
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xff63A288),
            bottom: TabBar(
              controller: controller,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              tabs: [
                Tab(
                    child: Text('Alle mærker',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.black))),
                Tab(
                    child: Text(
                        userProfile.id == loggedInUser.id
                            ? 'Mine mærker'
                            : '${userProfile.namePossessiveCase()} mærker',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.black))),
              ],
            ),
            title: Text(
              'Mærke oversigt',
              style: theme.primaryTextTheme.headline1!.copyWith(color: Colors.black),
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              BadgesTab(
                challengeBadges: state.allChallengeBadges,
                engagementBadges: state.allEngagementBadges,
                userProfile: loggedInUser,
                status: state.badgesStatus,
              ),
              BadgesTab(
                challengeBadges: state.userChallengeBadges,
                engagementBadges: state.userEngagementBadges,
                userProfile: userProfile,
                status: state.badgesStatus,
              ),
            ],
          ),
        );
      },
    );
  }
}
