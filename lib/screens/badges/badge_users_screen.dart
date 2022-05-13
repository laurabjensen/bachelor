import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/screens/badges/bloc/badges_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class BadgeUsersScreen extends StatefulWidget {
  final BadgesBloc badgesBloc;
  final BadgeSpecific badgeSpecific;

  const BadgeUsersScreen({Key? key, required this.badgesBloc, required this.badgeSpecific})
      : super(key: key);

  @override
  State<BadgeUsersScreen> createState() => _BadgeUsersScreenState();
}

class _BadgeUsersScreenState extends State<BadgeUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
        appBar: CustomAppBar.basicAppBarWithBackButton(
            title: widget.badgeSpecific.badge.name,
            onBack: () {
              Navigator.pop(context);
              widget.badgesBloc.add(ClearPeopleForBadgeSpecific());
            }),
        body: BlocBuilder(
            bloc: widget.badgesBloc,
            builder: (context, BadgesState state) {
              if (state.peopleForBadgeSpecific.isNotEmpty) {
                return ListView(
                    physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: GridView.count(
                              physics:
                                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                              shrinkWrap: true,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              crossAxisCount: 2,
                              children: List.generate(state.peopleForBadgeSpecific.length, (index) {
                                return ProfileFriendWidget(
                                  //badge: friends[index],
                                  userProfile: state.peopleForBadgeSpecific[index],
                                );
                              })))
                    ]);
              } else {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Text('Ingen brugere har dette mærke.',
                            style: theme.primaryTextTheme.headline2!.copyWith(fontSize: 18)),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
