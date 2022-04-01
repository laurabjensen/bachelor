import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/group/group_members_screen.dart';
import 'package:spejder_app/screens/group/members_screen.dart';
import 'package:spejder_app/screens/leader/leader_screen.dart';

import 'bloc/group_bloc.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late UserProfile userProfile;
  late GroupBloc groupBloc;

  @override
  void initState() {
    userProfile =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    groupBloc = GroupBloc(userProfile: userProfile);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      appBar: CustomAppBar.basicAppBar(
        title: userProfile.group.name,
        showBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              BlocBuilder(
                bloc: groupBloc,
                builder: (context, GroupState state) {
                  if (state.loadStatus == GroupLoadStatus.loaded) {
                    return Column(
                      children: [
                        userProfile.rank.title == 'Leder'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 70,
                                  width: 336,
                                  child: GestureDetector(
                                    onTap: () => pushNewScreen(context,
                                        screen: LeaderScreen(),
                                        withNavBar: false),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Leder',
                                              style: theme
                                                  .primaryTextTheme.headline3!
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
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70,
                            width: 336,
                            child: GestureDetector(
                              onTap: () => null,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Se patruljer',
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70,
                            width: 336,
                            child: GestureDetector(
                              onTap: () => pushNewScreen(context,
                                  screen: MembersScreen(
                                    withNavBar: false,
                                  ),
                                  withNavBar: false),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Se gruppemedlemmer',
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
    );
  }
}
