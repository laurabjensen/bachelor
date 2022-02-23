import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/login/bloc/login_bloc.dart';
import 'package:spejder_app/screens/signup/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ThemeData theme;
  late LoginBloc loginBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  void onLoginPressed() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      loginBloc.add(LoginPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Color(0xff63A288),
        body: BlocListener(
          bloc: loginBloc,
          listener: (context, LoginState state) {
            if (state.loginStateStatus == LoginStateStatus.loading) {
              //EasyLoading.show();
            } else if (state.loginStateStatus == LoginStateStatus.success) {
              //Navigator.pushNamed(context, AppRoutes.homeScreen);
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            } else if (state.loginStateStatus == LoginStateStatus.failure) {
              EasyLoading.showError(state.failureMessage);
            }
          },
          child: BlocBuilder(
              bloc: loginBloc,
              builder: (context, LoginState state) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 450,
                    decoration: BoxDecoration(
                        color: Color(0xffEEF2F3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: Image.asset('assets/logo_m_skrift.png'),
                          ),
                          LoginTextFormField(
                            labelText: 'E-mail',
                            value: '',
                            obscureText: false,
                            onChanged: (email) =>
                                loginBloc.add(EmailChanged(email!)),
                            validator: Validators.validateNotNull,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          LoginTextFormField(
                            labelText: 'Kodeord',
                            value: '',
                            obscureText: true,
                            onChanged: (password) =>
                                loginBloc.add(PasswordChanged(password!)),
                            validator: Validators.validateNotNull,
                            keyboardType: TextInputType.text,
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SizedBox(
                                  width: 118,
                                  height: 51,
                                  child: ElevatedButton(
                                      onPressed: () => onLoginPressed(),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff377E62)),
                                      child: Text(
                                        'Log ind',
                                        style: theme.primaryTextTheme.headline1,
                                      )))),
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, AppRoutes.resetScreen),
                              child: Text('Glemt kodeord?',
                                  style: theme.primaryTextTheme.headline3!
                                      .copyWith(fontStyle: FontStyle.italic))),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            child: SizedBox(
                              width: 260,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, AppRoutes.signupScreen),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffACC6B1)),
                                child: Text('Bliv en del af fællesskabet',
                                    style: theme.primaryTextTheme.headline3!
                                        .copyWith(fontSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
