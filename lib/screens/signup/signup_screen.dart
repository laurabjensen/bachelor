import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/components/group_dropdown.dart';
import 'package:spejder_app/validators.dart';

import 'bloc/signup_bloc.dart';
import 'components/rank_dropdown.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late ThemeData theme;
  late SignupBloc signupBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool agree = false;

  @override
  void initState() {
    super.initState();
    signupBloc = SignupBloc();
  }

  void onButtonPress() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      signupBloc.add(SignupPressed());
    }
  }

  // This function is triggered when the button is clicked
  void _doSomething() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      signupBloc.add(SignupPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return CustomScaffold(
      body: BlocListener(
          bloc: signupBloc,
          listener: (context, SignupState state) {
            if (state.signupStatus == SignupStateStatus.loading) {
              EasyLoading.show();
            } else if (state.signupStatus == SignupStateStatus.failure) {
              EasyLoading.showError(state.failureMessage);
            } else if (state.signupStatus == SignupStateStatus.success) {
              EasyLoading.showSuccess('Bruger oprettet');
              Navigator.pop(context);
            }
          },
          child: BlocBuilder(
              bloc: signupBloc,
              builder: (context, SignupState state) {
                if (state.groups.isNotEmpty && state.ranks.isNotEmpty) {
                  return Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          height: 700,
                          decoration: BoxDecoration(
                              color: Color(0xffEEF2F3),
                              borderRadius: BorderRadius.circular(15)),
                          child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Image.asset(
                                          'assets/logo_m_skrift.png'),
                                    ),
                                    LoginTextFormField(
                                        labelText: 'Navn',
                                        value: state.name,
                                        obscureText: false,
                                        validator: Validators.validateNotNull,
                                        onChanged: (name) =>
                                            signupBloc.add(NameChanged(name!)),
                                        keyboardType: TextInputType.name),
                                    //TODO: FIKS HER SÅ DET BLIVER VÆLG FØDSELSDAG
                                    LoginTextFormField(
                                      labelText: 'Alder',
                                      value: state.age == 0
                                          ? ''
                                          : state.age.toString(),
                                      obscureText: false,
                                      validator: Validators.validateNotNull,
                                      onChanged: (age) => signupBloc
                                          .add(AgeChanged(int.parse(age!))),
                                      keyboardType: TextInputType.number,
                                    ),
                                    LoginTextFormField(
                                      labelText: 'E-mail',
                                      value: state.email,
                                      obscureText: false,
                                      validator: Validators.validateNotNull,
                                      onChanged: (email) =>
                                          signupBloc.add(EmailChanged(email!)),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    LoginTextFormField(
                                      labelText: 'Kodeord',
                                      value: state.password,
                                      obscureText: true,
                                      validator: Validators.validateNotNull,
                                      onChanged: (password) => signupBloc
                                          .add(PasswordChanged(password!)),
                                      keyboardType: TextInputType.text,
                                    ),
                                    LoginTextFormField(
                                      labelText: 'Bekræft kodeord',
                                      value: state.passwordConfirm,
                                      obscureText: true,
                                      validator: Validators
                                          .validateConfirmationPassword,
                                      optionalValue: state.password,
                                      onChanged: (password) => signupBloc.add(
                                          ConfirmPasswordChanged(password!)),
                                      keyboardType: TextInputType.text,
                                    ),
                                    GroupDropDown(
                                      groups: state.groups,
                                      selectedGroup: state.group,
                                      onChanged: (group) =>
                                          signupBloc.add(GroupChanged(group)),
                                    ),
                                    RankDropdown(
                                        ranks: state.ranks,
                                        rank: state.rank,
                                        onChanged: (rank) =>
                                            signupBloc.add(RankChanged(rank))),
                                    //Terms and conditions
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 20, 8, 8),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Material(
                                              child: Checkbox(
                                                fillColor: MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        states.contains(
                                                                MaterialState
                                                                    .selected)
                                                            ? Color(0xff037B55)
                                                            : Colors.grey),
                                                shape: CircleBorder(),
                                                value: agree,
                                                onChanged: (value) {
                                                  setState(() {
                                                    agree = value ?? false;
                                                  });
                                                },
                                              ),
                                            ),
                                            const Text(
                                              'Jeg har læst og accepterer regler og vilkår',
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: SizedBox(
                                            width: 169,
                                            height: 51,
                                            child: ElevatedButton(
                                                onPressed:
                                                    agree ? _doSomething : null,
                                                child: Text('Opret Bruger',
                                                    style: theme
                                                        .primaryTextTheme
                                                        .headline1)),
                                          ),
                                        )
                                      ]),
                                    ),

                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Tilbage',
                                          style: theme
                                              .primaryTextTheme.headline1!
                                              .copyWith(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ))));
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
