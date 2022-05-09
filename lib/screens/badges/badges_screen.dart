import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/all_badges_tab.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';

import 'bloc/badges_bloc.dart';

class BadgesScreen extends StatefulWidget {
  final UserProfile userProfile;
  final int initialTabIndex;

  const BadgesScreen({Key? key, required this.userProfile, required this.initialTabIndex})
      : super(key: key);
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> with TickerProviderStateMixin {
  late UserProfile loggedInUser;
  late BadgesBloc badgesBloc;
  late TabController controller;

  @override
  void initState() {
    badgesBloc = BadgesBloc(userProfile: widget.userProfile);
    loggedInUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    controller = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
        create: (context) => badgesBloc,
        child: BlocBuilder<BadgesBloc, BadgesState>(
          bloc: badgesBloc,
          builder: (context, state) {
            return CustomScaffold(
              //backgroundColor: Color(0xff63A288),
              appBar: CustomAppBar.withTabBar(
                bottom: TabBar(
                  controller: controller,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2.5,
                  tabs: [
                    Tab(
                        child: Text('Alle mærker',
                            style:
                                theme.primaryTextTheme.headline2!.copyWith(color: Colors.white))),
                    Tab(
                        child: Text(
                            widget.userProfile.id == loggedInUser.id
                                ? 'Mine mærker'
                                : '${widget.userProfile.namePossessiveCase()} mærker',
                            style:
                                theme.primaryTextTheme.headline2!.copyWith(color: Colors.white))),
                  ],
                ),
                title: 'Mærke oversigt',
              ),
              body: TabBarView(
                controller: controller,
                children: [
                  BadgesTab(
                    challengeBadges: state.allChallengeBadges,
                    engagementBadges: state.allEngagementBadges,
                    jubileeBadges: state.allJubileeBadges,
                    userProfile: loggedInUser,
                    status: state.badgesStatus,
                  ),
                  BadgesTab(
                    challengeBadges: state.userChallengeBadges,
                    engagementBadges: state.userEngagementBadges,
                    jubileeBadges: state.userJubileeBadges,
                    userProfile: widget.userProfile,
                    status: state.badgesStatus,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
