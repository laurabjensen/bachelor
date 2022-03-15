import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/home/home_card_widget.dart';
import 'package:spejder_app/screens/home/leader_card_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget showLeaderCard(bool isLeader, UserProfile userProfile) {
    if (isLeader) {
      return LeaderCardWidget(
        color: Color(0xffC4C4C4),
        text: 'Leder',
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.leaderScreen, arguments: userProfile),
        imgPath: 'assets/leder_ikon.svg',
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, AuthenticationState state) {
          if (state.userProfile != null) {
            final isLeader = state.userProfile!.rank.title == 'Leder';
            return CustomScaffold(
                body: SafeArea(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCardWidget(
                      color: Color(0xffDC3E41),
                      text: 'Min Profil',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.profileScreen,
                          arguments: state.userProfile),
                      imgPath: 'assets/profil_ikon.svg',
                      isLeader: isLeader,
                    ),
                    HomeCardWidget(
                      color: Color(0xffE9993E),
                      text: 'Mærker',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.badgesScreen,
                          arguments: state.userProfile),
                      imgPath: 'assets/mærke_ikon.svg',
                      isLeader: isLeader,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCardWidget(
                      color: Color(0xffA82277),
                      text: 'Gruppe',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.groupScreen),
                      imgPath: 'assets/gruppe_ikon.svg',
                      isLeader: isLeader,
                    ),
                    HomeCardWidget(
                      color: Color(0xff211F4A),
                      text: 'Venner',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.friendsScreen),
                      imgPath: 'assets/venner_ikon.svg',
                      isLeader: isLeader,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: showLeaderCard(isLeader, state.userProfile!),
                )
              ],
            )));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
