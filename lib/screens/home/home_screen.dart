import 'package:flutter/material.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/home/home_card_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget showLeaderCard() {
    return HomeCardWidget(
      color: Color(0xffC4C4C4),
      text: 'Leder',
      onPressed: () => Navigator.pushNamed(context, AppRoutes.leaderScreen),
      width: 336,
      height: 111,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCardWidget(
              color: Color(0xff377E62),
              text: 'Min Profil',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profileScreen),
            ),
            HomeCardWidget(
              color: Color(0xffE9993E),
              text: 'Mærker',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.badgesScreen),
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
            ),
            HomeCardWidget(
              color: Color(0xff211F4A),
              text: 'Venner',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.friendsScreen),
            )
          ],
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: showLeaderCard(),
        )*/
      ],
    )));
  }
}
