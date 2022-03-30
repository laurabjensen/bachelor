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

class FriendsActivityScreen extends StatefulWidget {
  final UserProfile userProfile;

  const FriendsActivityScreen({Key? key, required this.userProfile})
      : super(key: key);
  @override
  State<FriendsActivityScreen> createState() => _FriendsActivityScreenState();
}

class _FriendsActivityScreenState extends State<FriendsActivityScreen> {
  late UserProfile currentUser;

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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ApproveFriendWidget(
                    // TODO: RegretFriendWidget kan også bruges
                    userProfile: widget.userProfile,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
