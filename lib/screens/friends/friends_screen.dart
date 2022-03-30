import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/friends/components/all_friends_tab.dart';
import 'package:spejder_app/screens/friends/bloc/friends_bloc.dart';
import 'package:spejder_app/screens/friends/friends_activity/friends_activity_screen.dart';

class FriendsScreen extends StatefulWidget {
  final UserProfile userProfile;
  final int initialTabIndex;

  const FriendsScreen({Key? key, required this.userProfile, required this.initialTabIndex})
      : super(key: key);
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with TickerProviderStateMixin {
  late UserProfile currentUser;

  late FriendsBloc friendsBloc;
  late TabController controller;

  @override
  void initState() {
    super.initState();

    friendsBloc = FriendsBloc(userProfile: widget.userProfile);
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    controller = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<FriendsBloc, FriendsState>(
      bloc: friendsBloc,
      builder: (context, state) {
        return CustomScaffold(
          appBar: CustomAppBar.withTabBar(
            actions: <Widget>[
              Stack(
                children: [
                  Stack(
                    children: [
                      Icon(Icons.circle, size: 25, color: Colors.red),
                      Positioned(
                        left: 10,
                        top: 3,
                        child: Text('1', //TODO! FIX HER SÅ DET IK ER HARDCODED
                            style: theme.primaryTextTheme.headline1!.copyWith(
                                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  IconButton(
                      tooltip: 'Se veninde aktivitet',
                      icon: Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      onPressed: () => pushNewScreen(context,
                          screen: FriendsActivityScreen(
                            userProfile: widget.userProfile,
                          ),
                          withNavBar: false)),
                ],
              )
            ],
            bottom: TabBar(
              controller: controller,
              indicatorColor: Colors.white,
              indicatorWeight: 2.5,
              tabs: [
                Tab(
                    child: Text('Alle veninder',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.white))),
                Tab(
                    child: Text(
                        widget.userProfile.id == currentUser.id
                            ? 'Mine veninder'
                            : '${widget.userProfile.namePossessiveCase()} veninder',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.white))),
              ],
            ),
            title: 'Veninder oversigt',
          ),
          body: TabBarView(
            controller: controller,
            children: [
              FriendsTab(friends: state.allUsers, userProfile: currentUser),
              FriendsTab(
                friends: state.allUserFriends,
                userProfile: widget.userProfile,
              )
            ],
          ),
        );
      },
    );
  }
}
