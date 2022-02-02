import 'package:flutter/material.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTextFormField(
            labelText: 'Brugernavn',
          ),
          LoginTextFormField(
            labelText: 'Kodeord',
          ),
          ElevatedButton(onPressed: () => null, child: Text('Login')),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.signupScreen),
              child: Text('Tilmeld'))
        ],
      )),
    );
  }
}
