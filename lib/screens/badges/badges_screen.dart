import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/all_badges_tab.dart';

import 'bloc/badges_bloc.dart';

class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  late UserProfile currentUser;
  late UserProfile userProfile = ModalRoute.of(context)!.settings.arguments as UserProfile;
  late BadgesBloc badgesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    badgesBloc = BadgesBloc();
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadgesBloc, BadgesState>(
      bloc: badgesBloc,
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Color(0xff63A288),
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Color(0xffEEF2F3),
              bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                tabs: [
                  Tab(child: Text('Alle mærker', style: TextStyle(color: Colors.black))),
                  Tab(
                      child: Text(
                          userProfile.id == currentUser.id
                              ? 'Mine mærker'
                              : '${userProfile.name} mærker',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
              title: const Text(
                'Mærker',
                style: TextStyle(
                  color: Colors.black,
                ),
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
                  userProfile: userProfile,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
