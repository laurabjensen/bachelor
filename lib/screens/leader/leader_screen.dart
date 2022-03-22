import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/leader/bloc/leader_bloc.dart';

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
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 60, left: 10),
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Text(
                  userProfile.name,
                  style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                ),
                Text(
                  userProfile.group.name,
                  style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 17),
                ),
                BlocBuilder(
                  bloc: leaderBloc,
                  builder: (context, LeaderState state) {
                    if (state.loadStatus == LeaderLoadStatus.loaded) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 70,
                              width: 336,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.approveBadgesScreen,
                                  arguments: leaderBloc,
                                ),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Godkend mærker',
                                          style: theme.primaryTextTheme.headline3!
                                              .copyWith(fontSize: 20),
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
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 70,
                              width: 336,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.createPatrolScreen,
                                    arguments: userProfile),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Registrer patrulje',
                                          style: theme.primaryTextTheme.headline3!
                                              .copyWith(fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
