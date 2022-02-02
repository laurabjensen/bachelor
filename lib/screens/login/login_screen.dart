import 'package:flutter/material.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/validators.dart';

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
          ClipRRect(
            child: Image.asset('assets/logo_m_skrift.png'),
          ),
          LoginTextFormField(
            labelText: 'Brugernavn',
            value: '',
            obscureText: false,
            onChanged: (_) => null,
            validator: Validators.validateNotNull,
          ),
          LoginTextFormField(
            labelText: 'Kodeord',
            value: '',
            obscureText: true,
            onChanged: (_) => null,
            validator: Validators.validateNotNull,
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
