import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/all_badges_tab.dart';

import 'bloc/badges_bloc.dart';

class BadgesScreen extends StatefulWidget {
  final UserProfile userProfile;

  const BadgesScreen({Key? key, required this.userProfile}) : super(key: key);
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  late UserProfile currentUser;
  late BadgesBloc badgesBloc;

  @override
  void initState() {
    super.initState();
    badgesBloc = BadgesBloc(userProfile: widget.userProfile);
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  // TODO! Find ud af hvad vi skal gøre med background svg her!!!
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BadgesBloc, BadgesState>(
      bloc: badgesBloc,
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Color(0xff63A288),
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Color(0xff63A288),
              bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                      child: Text('Alle mærker',
                          style: theme.primaryTextTheme.headline2!
                              .copyWith(color: Colors.black))),
                  Tab(
                      child: Text(
                          widget.userProfile.id == currentUser.id
                              ? 'Mine mærker'
                              : '${widget.userProfile.name} mærker',
                          style: theme.primaryTextTheme.headline2!
                              .copyWith(color: Colors.black))),
                ],
              ),
              title: Text(
                'Mærke oversigt',
                style: theme.primaryTextTheme.headline1!
                    .copyWith(color: Colors.black),
              ),
            ),
            body: TabBarView(
              children: [
                BadgesTab(
                    challengeBadges: state.allChallengeBadges,
                    engagementBadges: state.allEngagementBadges,
                    userProfile: currentUser),
                BadgesTab(
                  challengeBadges: state.userChallengeBadges,
                  engagementBadges: state.userEngagementBadges,
                  userProfile: widget.userProfile,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
