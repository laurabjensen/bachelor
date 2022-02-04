import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
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
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/tørklæde.png'), fit: BoxFit.cover)),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 723,
                            decoration: BoxDecoration(
                                color: Color(0xffEEF2F3), borderRadius: BorderRadius.circular(15)),
                            child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        child: Image.asset('assets/logo_m_skrift.png'),
                                      ),
                                      LoginTextFormField(
                                          labelText: 'Navn',
                                          value: state.name,
                                          obscureText: false,
                                          validator: Validators.validateNotNull,
                                          onChanged: (name) => signupBloc.add(NameChanged(name!)),
                                          keyboardType: TextInputType.name),
                                      LoginTextFormField(
                                        labelText: 'Alder',
                                        value: state.age == 0 ? '' : state.age.toString(),
                                        obscureText: false,
                                        validator: Validators.validateNotNull,
                                        onChanged: (age) =>
                                            signupBloc.add(AgeChanged(int.parse(age!))),
                                        keyboardType: TextInputType.number,
                                      ),
                                      LoginTextFormField(
                                        labelText: 'E-mail',
                                        value: state.email,
                                        obscureText: false,
                                        validator: Validators.validateNotNull,
                                        onChanged: (email) => signupBloc.add(EmailChanged(email!)),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      LoginTextFormField(
                                        labelText: 'Kodeord',
                                        value: state.password,
                                        obscureText: true,
                                        validator: Validators.validateNotNull,
                                        onChanged: (password) =>
                                            signupBloc.add(PasswordChanged(password!)),
                                        keyboardType: TextInputType.text,
                                      ),
                                      LoginTextFormField(
                                        labelText: 'Bekræft kodeord',
                                        value: state.passwordConfirm,
                                        obscureText: true,
                                        validator: Validators.validateConfirmationPassword,
                                        optionalValue: state.password,
                                        onChanged: (password) =>
                                            signupBloc.add(ConfirmPasswordChanged(password!)),
                                        keyboardType: TextInputType.text,
                                      ),
                                      GroupDropDown(
                                        groups: state.groups,
                                        selectedGroup: state.group,
                                        onChanged: (group) => signupBloc.add(GroupChanged(group)),
                                      ),
                                      RankDropdown(
                                          ranks: state.ranks,
                                          rank: state.rank,
                                          onChanged: (rank) => signupBloc.add(RankChanged(rank))),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Container(
                                              width: 169,
                                              height: 51,
                                              child: ElevatedButton(
                                                  onPressed: () => onButtonPress(),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Color(0xff377E62)),
                                                  child: Text(
                                                    'Opret bruger',
                                                    style: GoogleFonts.barlow(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  )))),
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            'Tilbage',
                                            style: GoogleFonts.barlow(
                                                fontSize: 20, color: Colors.black),
                                          ))
                                    ],
                                  ),
                                ))))
                  ],
                );
              })),
    );
  }
}
