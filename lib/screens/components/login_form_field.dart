import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String labelText;

  const LoginTextFormField({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(border: UnderlineInputBorder(), labelText: labelText),
    );
  }
}
