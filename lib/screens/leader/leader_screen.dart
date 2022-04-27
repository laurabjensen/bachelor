import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_tab_card.dart';
import 'package:spejder_app/screens/leader/approve_badges_screen.dart';
import 'package:spejder_app/screens/leader/bloc/leader_bloc.dart';
import 'package:spejder_app/screens/patrol/create_patrol_screen.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';

class LeaderScreen extends StatefulWidget {
  @override
  _LeaderScreenState createState() => _LeaderScreenState();
}

class _LeaderScreenState extends State<LeaderScreen> {
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
      appBar: CustomAppBar.basicAppBarWithBackButton(
        title: 'Leder',
        onBack: () => Navigator.pop(context),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              BlocBuilder(
                bloc: leaderBloc,
                builder: (context, LeaderState state) {
                  if (state.loadStatus == LeaderLoadStatus.loaded) {
                    return Column(
                      children: [
                        CustomTabCard(
                          onTap: () => pushNewScreen(context,
                              screen: ApproveBadgesScreen(
                                leaderBloc: leaderBloc,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Godkend mærker',
                                style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 20),
                              ),
                              state.badgeRegistrations.isNotEmpty
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.badgeRegistrations.length.toString(),
                                          style: theme.primaryTextTheme.bodyText2!
                                              .copyWith(fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                            ],
                          ),
                        ),
                        CustomTabCard(
                          onTap: () => pushNewScreen(context,
                              screen: CreatePatrolScreen(userProfile: userProfile),
                              withNavBar: false),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Registrer patrulje',
                                style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  // Used to make time to load amount of user requests
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
