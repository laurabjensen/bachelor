import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/friends/components/approve_friend_widget.dart';
import 'package:spejder_app/screens/friends/friends_activity/bloc/friends_activity_bloc.dart';

class FriendsActivityScreen extends StatefulWidget {
  final UserProfile userProfile;

  const FriendsActivityScreen({Key? key, required this.userProfile}) : super(key: key);
  @override
  State<FriendsActivityScreen> createState() => _FriendsActivityScreenState();
}

class _FriendsActivityScreenState extends State<FriendsActivityScreen> {
  late UserProfile currentUser;
  late FriendsActivityBloc friendsActivityBloc;

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    friendsActivityBloc = FriendsActivityBloc(widget.userProfile);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = GetIt.instance.get<List<UserProfile>>();

    Widget noImageWidget() {
      return Stack(
        children: [
          Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xffFED105),
              )),
          Positioned(
              left: 3.5,
              top: 5,
              child: SvgPicture.asset(
                'assets/tørklæde_rød.svg',
                height: 80,
                width: 80,
                fit: BoxFit.scaleDown,
              )),
        ],
      );
    }

    return CustomScaffold(
        appBar: CustomAppBar.basicAppBarWithBackButton(
          title: 'Veninde aktivitet',
          onBack: () => Navigator.pop(context),
        ),
        body: BlocBuilder(
            bloc: friendsActivityBloc,
            builder: (context, FriendsActivityState state) {
              if (state.userProfile.friendRequestsReceived.isNotEmpty &&
                  state.userProfiles.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.userProfiles.length,
                  itemBuilder: (context, index) {
                    return ApproveFriendWidget(
                      // TODO: RegretFriendWidget kan også bruges
                      userProfile: state.userProfiles[index],
                      onAcceptFriend: () =>
                          friendsActivityBloc.add(AcceptFriend(state.userProfiles[index])),
                      onRejectFriend: () =>
                          friendsActivityBloc.add(RejectFriend(state.userProfiles[index])),
                    );
                  },
                );
              } else if (state.userProfile.friendRequestsReceived.isNotEmpty &&
                  state.userProfiles.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    heightFactor: 2,
                    child: Text(
                      'Ingen nye veninde anmodninger i øjeblikket.',
                      style: Theme.of(context).primaryTextTheme.headline2!.copyWith(fontSize: 16),
                    ),
                  ),
                );
              }
            }));
  }
}
