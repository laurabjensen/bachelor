import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String labelText;
  final String value;
  final bool obscureText;
  final Function(String?) onChanged;

  LoginTextFormField(
      {Key? key,
      required this.labelText,
      required this.value,
      required this.obscureText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //controller: TextEditingController(text: value),
      decoration: InputDecoration(border: UnderlineInputBorder(), labelText: labelText),
      onChanged: onChanged,
      initialValue: value,
      obscureText: obscureText,
    );
  }
}
