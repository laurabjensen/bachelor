import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/group_dropdown.dart';

import 'bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupBloc signupBloc;

  @override
  void initState() {
    // TODO: implement initState
    signupBloc = SignupBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocBuilder(
          bloc: signupBloc,
          builder: (context, SignupState state) {
            return Column(
              children: [
                LoginTextFormField(labelText: 'Navn'),
                LoginTextFormField(labelText: 'Brugernavn'),
                LoginTextFormField(labelText: 'Kodeord'),
                LoginTextFormField(labelText: 'Bekræft kodeord'),
                GroupDropDown(
                  groups: state.groups,
                ),
                //RankDropdown(),
                ElevatedButton(onPressed: () => null, child: Text('Opret bruger'))
              ],
            );
          }),
    ));
  }
}
