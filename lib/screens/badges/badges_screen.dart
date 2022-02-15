import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/badges/all_badges_tab.dart';
import 'package:spejder_app/screens/badges/my_badges_tab.dart';

import 'bloc/badges_bloc.dart';

class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  late BadgesBloc badgesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    badgesBloc = BadgesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadgesBloc, BadgesState>(
      bloc: badgesBloc,
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Color(0xff63A288),
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              bottom: const TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                tabs: [
                  Tab(child: Text('Alle mærker', style: TextStyle(color: Colors.black))),
                  Tab(child: Text('Mine mærker', style: TextStyle(color: Colors.black))),
                ],
              ),
              title: const Text('Mærker'),
            ),
            body: TabBarView(
              children: [
                AllBadgesTab(
                  badges: state.allBadges,
                ),
                MyBadgesTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
