import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/app_theme.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/screens/badges/badges_screen.dart';
import 'package:spejder_app/screens/badges/registration/register_badge_screen.dart';
import 'package:spejder_app/screens/badges/specific_badge_screen.dart';
import 'package:spejder_app/screens/friends/friends_activity/friends_activity_screen.dart';
import 'package:spejder_app/screens/group/group_screen.dart';
import 'package:spejder_app/screens/home/home_screen.dart';
import 'package:spejder_app/screens/leader/approve_badges_screen.dart';
import 'package:spejder_app/screens/leader/leader_screen.dart';
import 'package:spejder_app/screens/login/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/screens/patrol/create_patrol_screen.dart';
import 'package:spejder_app/screens/profile/profile_screen.dart';
import 'package:spejder_app/screens/reset/reset_screen.dart';
import 'package:spejder_app/screens/signup/signup_screen.dart';
import 'package:spejder_app/screens/friends/friends_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/* 
  Root for app. 
  Ved opstart navigere den til den rigtige skærm baseret på om brugeren er logget ind eller skal logge ind.
*/
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = GetIt.instance.get<AuthenticationBloc>();
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', ''), Locale('da', 'DK')],
        routes: {
          AppRoutes.signupScreen: (context) => SignupScreen(),
          AppRoutes.homeScreen: (context) => HomeScreen(),
          AppRoutes.badgesScreen: (context) =>
              BadgesScreen(userProfile: ModalRoute.of(context)!.settings.arguments as UserProfile),
          AppRoutes.profileScreen: (context) => ProfileScreen(),
          AppRoutes.groupScreen: (context) => GroupScreen(),
          AppRoutes.leaderScreen: (context) => LeaderScreen(),
          AppRoutes.friendsScreen: (context) =>
              FriendsScreen(userProfile: ModalRoute.of(context)!.settings.arguments as UserProfile),
          AppRoutes.friendsActivityScreen: (context) => FriendsActivityScreen(),
          AppRoutes.specificBadgeScreen: (context) =>
              SpecificBadgeScreen(badge: ModalRoute.of(context)!.settings.arguments as Badge),
          AppRoutes.registerBadgeScreen: (context) => RegisterBadgeScreen(
              badgeSpecific: ModalRoute.of(context)!.settings.arguments as BadgeSpecific),
          AppRoutes.resetScreen: (context) => ResetScreen(),
          AppRoutes.approveBadgesScreen: (context) => ApproveBadgesScreen(),
          AppRoutes.createPatrolScreen: (context) => CreatePatrolScreen(
                userProfile: ModalRoute.of(context)!.settings.arguments as UserProfile,
              ),
        },
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            switch (state.status) {
              case AuthenticationStateStatus.authenticated:
                return HomeScreen();
              case AuthenticationStateStatus.unauthenticated:
              default:
                return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
