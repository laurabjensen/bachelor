import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/screens/main.dart';

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
        // * TODO: routes: ,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            return MainScreen();
          },
        ),
      ),
    );
  }
}
