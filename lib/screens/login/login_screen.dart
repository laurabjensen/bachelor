import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/login/bloc/login_bloc.dart';
import 'package:spejder_app/screens/signup/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener(
          bloc: loginBloc,
          listener: (context, LoginState state) {
            if (state.loginStateStatus == LoginStateStatus.loading) {
              EasyLoading.show();
            } else if (state.loginStateStatus == LoginStateStatus.success) {
              Navigator.pushNamed(context, AppRoutes.homeScreen);
              EasyLoading.showSuccess('');
            } else if (state.loginStateStatus == LoginStateStatus.failure) {
              EasyLoading.showError(state.failureMessage);
            }
          },
          child: BlocBuilder(
              bloc: loginBloc,
              builder: (context, LoginState state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      child: Image.asset('assets/logo_m_skrift.png'),
                    ),
                    LoginTextFormField(
                      labelText: 'Email',
                      value: '',
                      obscureText: false,
                      onChanged: (email) => loginBloc.add(EmailChanged(email!)),
                      validator: Validators.validateNotNull,
                    ),
                    LoginTextFormField(
                      labelText: 'Kodeord',
                      value: '',
                      obscureText: true,
                      onChanged: (password) => loginBloc.add(PasswordChanged(password!)),
                      validator: Validators.validateNotNull,
                    ),
                    ElevatedButton(
                        onPressed: () => loginBloc.add(LoginPressed()), child: Text('Login')),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.signupScreen),
                        child: Text('Tilmeld'))
                  ],
                );
              })),
    ));
  }
}
