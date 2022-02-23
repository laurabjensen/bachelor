import 'package:flutter/material.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/login/bloc/login_bloc.dart';
import 'package:spejder_app/screens/signup/validators.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late ThemeData theme;
  late LoginBloc loginBloc; //TODO: er det rigtigt at det skal være loginbloc?

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return Scaffold(
        backgroundColor: Color(0xff63A288),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 450,
            decoration: BoxDecoration(
                color: Color(0xffEEF2F3),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset('assets/logo_m_skrift.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text(
                    'Har du glemt dit kodeord? \nBare rolig! Indtast din mail så kan du få det nulstillet.',
                    style: theme.primaryTextTheme.headline3,
                  ),
                ),
                LoginTextFormField(
                  labelText: 'E-mail',
                  value: '',
                  obscureText: false,
                  onChanged: (email) => loginBloc.add(EmailChanged(email!)),
                  validator: Validators.validateNotNull,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: SizedBox(
                    width: 118,
                    height: 51,
                    child: ElevatedButton(
                      onPressed: () => null,
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                      child: Text(
                        'Send mail',
                        style: theme.primaryTextTheme.headline1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 118,
                    height: 51,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffACC6B1)),
                      child: Text(
                        'Fortryd',
                        style: theme.primaryTextTheme.headline1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
