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
    return Scaffold(
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
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/tørklæde.png'), fit: BoxFit.cover)),
              ),
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 400,
                      decoration: BoxDecoration(
                          color: Color(0xffEEF2F3), borderRadius: BorderRadius.circular(15)),
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
                                onChanged: (email) => loginBloc.add(EmailChanged(email!)),
                                validator: Validators.validateNotNull,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              LoginTextFormField(
                                labelText: 'Kodeord',
                                value: '',
                                obscureText: true,
                                onChanged: (password) => loginBloc.add(PasswordChanged(password!)),
                                validator: Validators.validateNotNull,
                                keyboardType: TextInputType.text,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Container(
                                      width: 118,
                                      height: 51,
                                      child: ElevatedButton(
                                          onPressed: () => onLoginPressed(),
                                          style:
                                              ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                                          child: Text(
                                            'Log ind',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )))),
                              TextButton(
                                  onPressed: () => null,
                                  child: Text(
                                    'Glemt kodeord?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, AppRoutes.signupScreen),
                                  child: Text('Bliv en del af fællesskabet',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline)))
                            ],
                          ))))
            ]);
          }),
    ));
  }
}
