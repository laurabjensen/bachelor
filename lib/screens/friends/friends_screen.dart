import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/friends/components/all_friends_tab.dart';
import 'package:spejder_app/screens/friends/bloc/friends_bloc.dart';

class FriendsScreen extends StatefulWidget {
  final Map args;

  const FriendsScreen({Key? key, required this.args}) : super(key: key);
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with TickerProviderStateMixin {
  late UserProfile currentUser;
  late UserProfile userProfile;
  late int initialTabIndex;
  late FriendsBloc friendsBloc;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    userProfile = widget.args['userprofile'];
    initialTabIndex = widget.args['initialTabIndex'];
    friendsBloc = FriendsBloc(userProfile: userProfile);
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    controller = TabController(length: 2, vsync: this, initialIndex: initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<FriendsBloc, FriendsState>(
      bloc: friendsBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff63A288),
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xff63A288),
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
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.friendsActivityScreen,
                        arguments: userProfile),
                  ),
                ],
              )
            ],
            bottom: TabBar(
              controller: controller,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              tabs: [
                Tab(
                    child: Text('Alle veninder',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.black))),
                Tab(
                    child: Text(
                        userProfile.id == currentUser.id
                            ? 'Mine veninder'
                            : '${userProfile.namePossessiveCase()} veninder',
                        style: theme.primaryTextTheme.headline2!.copyWith(color: Colors.black))),
              ],
            ),
            title: Text(
              'Veninder oversigt',
              style: theme.primaryTextTheme.headline1!.copyWith(color: Colors.black),
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              FriendsTab(friends: state.allUsers, userProfile: currentUser),
              FriendsTab(
                friends: state.allUserFriends,
                userProfile: userProfile,
              )
            ],
          ),
        );
      },
    );
  }
}
