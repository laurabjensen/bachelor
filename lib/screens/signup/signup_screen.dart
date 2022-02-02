import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/group_dropdown.dart';

import 'bloc/signup_bloc.dart';
import 'rank_dropdown.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupBloc signupBloc;
  late TextEditingController nameController;
  late TextEditingController usernameController;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginTextFormField(
                  labelText: 'Navn',
                  value: state.name,
                  obscureText: false,
                  onChanged: (name) => signupBloc.add(NameChanged(name!)),
                ),
                LoginTextFormField(
                  labelText: 'Brugernavn',
                  value: state.username,
                  obscureText: false,
                  onChanged: (username) => signupBloc.add(UsernameChanged(username!)),
                ),
                LoginTextFormField(
                    labelText: 'Kodeord',
                    value: state.password,
                    obscureText: true,
                    onChanged: (password) => signupBloc.add(PasswordChanged(password!))),
                LoginTextFormField(
                    labelText: 'Bekræft kodeord',
                    value: state.passwordConfirm,
                    obscureText: true,
                    onChanged: (password) => signupBloc.add(PasswordChanged(password!))),
                GroupDropDown(
                  groups: state.groups,
                  selectedGroup: state.group,
                  onChanged: (group) => signupBloc.add(GroupChanged(group)),
                ),
                RankDropdown(
                    ranks: state.ranks,
                    rank: state.rank,
                    onChanged: (rank) => signupBloc.add(RankChanged(rank))),
                ElevatedButton(onPressed: () => null, child: Text('Opret bruger')),
              ],
            );
          }),
    ));
  }
}
