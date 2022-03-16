import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/friends/components/approve_friend_widget.dart';
import 'package:spejder_app/screens/friends/components/regret_friend_widget.dart';
import 'package:spejder_app/screens/leader/components/approve_badge_widget.dart';

import '../../../model/badge.dart';

class FriendsActivityScreen extends StatefulWidget {
  @override
  State<FriendsActivityScreen> createState() => _FriendsActivityScreenState();
}

class _FriendsActivityScreenState extends State<FriendsActivityScreen> {
  late UserProfile currentUser;
  late UserProfile userProfile =
      ModalRoute.of(context)!.settings.arguments as UserProfile;

  @override
  void initState() {
    super.initState();
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = GetIt.instance.get<List<UserProfile>>();

    return CustomScaffold(
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 40, left: 10),
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Veninde aktivitet',
                    style: theme.primaryTextTheme.headline1!
                        .copyWith(fontSize: 30),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ApproveFriendWidget(
                        // TODO: RegretFriendWidget kan også bruges
                        userProfile: userProfile,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
