import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/leader/bloc/leader_bloc.dart';
import 'package:spejder_app/screens/leader/components/approve_badge_widget.dart';

class ApproveBadgesScreen extends StatefulWidget {
  @override
  _ApproveBadgesScreenState createState() => _ApproveBadgesScreenState();
}

class _ApproveBadgesScreenState extends State<ApproveBadgesScreen> {
  late UserProfile userProfile;
  late LeaderBloc leaderBloc;

  @override
  void initState() {
    super.initState();
    userProfile = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    leaderBloc = LeaderBloc(userProfile: userProfile);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 40, left: 10),
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Godkend mærker',
                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                  ),
                ),
                BlocBuilder(
                    bloc: leaderBloc,
                    builder: (context, LeaderState state) {
                      if (state.loadStatus == LeaderBadgeRegistrationLoadStatus.loaded) {
                        if (state.badgeRegistrations.isNotEmpty) {
                          return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.badgeRegistrations.length,
                                  itemBuilder: (context, index) {
                                    return ApproveBadgeWidget(
                                      badgeRegistration: state.badgeRegistrations[index],
                                    );
                                  }));
                        } else {
                          return Text(
                              'Der ligger ingen mærker til godkendelse hos dig i øjeblikket',
                              style: theme.primaryTextTheme.headline2!.copyWith(fontSize: 17));
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
