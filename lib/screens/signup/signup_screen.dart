import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/components/group_dropdown.dart';
import 'package:spejder_app/screens/signup/validators.dart';

import 'bloc/signup_bloc.dart';
import 'components/rank_dropdown.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupBloc signupBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    signupBloc = SignupBloc();
  }

  void onButtonPress() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      signupBloc.add(SignupPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocBuilder(
          bloc: signupBloc,
          builder: (context, SignupState state) {
            return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LoginTextFormField(
                        labelText: 'Navn',
                        value: state.name,
                        obscureText: false,
                        validator: Validators.validateNotNull,
                        onChanged: (name) => signupBloc.add(NameChanged(name!)),
                      ),
                      LoginTextFormField(
                        labelText: 'Brugernavn',
                        value: state.username,
                        obscureText: false,
                        validator: Validators.validateNotNull,
                        onChanged: (username) => signupBloc.add(UsernameChanged(username!)),
                      ),
                      LoginTextFormField(
                          labelText: 'Kodeord',
                          value: state.password,
                          obscureText: true,
                          validator: Validators.validateNotNull,
                          onChanged: (password) => signupBloc.add(PasswordChanged(password!))),
                      LoginTextFormField(
                          labelText: 'Bekræft kodeord',
                          value: state.passwordConfirm,
                          obscureText: true,
                          validator: Validators.validateConfirmationPassword,
                          optionalValue: state.password,
                          onChanged: (password) =>
                              signupBloc.add(ConfirmPasswordChanged(password!))),
                      GroupDropDown(
                        groups: state.groups,
                        selectedGroup: state.group,
                        onChanged: (group) => signupBloc.add(GroupChanged(group)),
                      ),
                      RankDropdown(
                          ranks: state.ranks,
                          rank: state.rank,
                          onChanged: (rank) => signupBloc.add(RankChanged(rank))),
                      ElevatedButton(onPressed: () => onButtonPress(), child: Text('Opret bruger')),
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('Tilbage'))
                    ],
                  ),
                ));
          }),
    ));
  }
}
