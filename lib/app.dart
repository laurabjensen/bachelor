import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/app_theme.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/screens/home/home_screen.dart';
import 'package:spejder_app/screens/login/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/screens/signup/signup_screen.dart';

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
        routes: {
          AppRoutes.signupScreen: (context) => SignupScreen(),
          AppRoutes.homeScreen: (context) => HomeScreen()
        },
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
