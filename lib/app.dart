import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/app_theme.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/screens/badges/badges_screen.dart';
import 'package:spejder_app/screens/badges/registration/register_badge_screen.dart';
import 'package:spejder_app/screens/badges/specific_badge_screen.dart';
import 'package:spejder_app/screens/components/navigation.dart';
import 'package:spejder_app/screens/friends/friends_activity/friends_activity_screen.dart';
import 'package:spejder_app/screens/group/group_members_screen.dart';
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', ''), Locale('da', 'DK')],
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            switch (state.status) {
              case AuthenticationStateStatus.authenticated:
                return LoggedInNavigationController();
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
