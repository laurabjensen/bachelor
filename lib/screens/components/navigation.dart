import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/badges_screen.dart';
import 'package:spejder_app/screens/components/custom_nav_bar.dart';
import 'package:spejder_app/screens/feed/feed_screen.dart';
import 'package:spejder_app/screens/friends/friends_screen.dart';
import 'package:spejder_app/screens/group/group_screen.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';

class LoggedInNavigationController extends StatefulWidget {
  @override
  _LoggedInNavigationControllerState createState() => _LoggedInNavigationControllerState();
}

class _LoggedInNavigationControllerState extends State<LoggedInNavigationController> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late UserProfile currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    _controller = PersistentTabController(initialIndex: 2);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      GroupScreen(),
      BadgesScreen(
        userProfile: currentUser,
        initialTabIndex: 0,
      ),
      FeedScreen(),
      FriendsScreen(
        userProfile: currentUser,
        initialTabIndex: 0,
      ),
      ProfileScreen(
        userProfile: currentUser,
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today),
        title: '',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.backpack_outlined),
        title: '',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.perm_identity),
        title: '',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  items() {
    return [
      TabItem<SvgPicture>(
          icon: SvgPicture.asset(
            'assets/fire.svg',
          ),
          title: 'Gruppe'),
      TabItem<SvgPicture>(
          icon: SvgPicture.asset(
            'assets/badges.svg',
          ),
          title: 'Mærker'),
      TabItem<SvgPicture>(
          icon: SvgPicture.asset(
            'assets/feed.svg',
          ),
          title: 'Aktivitet'),
      TabItem<SvgPicture>(
          icon: SvgPicture.asset(
            'assets/friends.svg',
          ),
          title: 'Veninder'),
      TabItem<SvgPicture>(
          icon: SvgPicture.asset(
            'assets/profile.svg',
          ),
          title: 'Profil'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        screens: _buildScreens(),
        confineInSafeArea: true,
        itemCount: 5,
        //items: _navBarItems(),

        stateManagement: true,
        backgroundColor: Color(0xff377E62),
        hideNavigationBar: _hideNavBar,
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(microseconds: 5000),
        ),
        customWidget: CustomBottomNavBar(
          items: items(),
          onTap: (index) {
            setState(() {
              _controller.index = index;
            });
          },
          initialActiveIndex: _controller.index,
        ),
      ),
    );
  }
}
