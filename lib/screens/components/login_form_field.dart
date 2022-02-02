import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String labelText;
  final String value;
  final bool obscureText;
  final String? Function(String?, String?) validator;
  final String? optionalValue;
  final Function(String?) onChanged;

  LoginTextFormField(
      {Key? key,
      required this.labelText,
      required this.value,
      this.optionalValue,
      required this.obscureText,
      required this.validator,
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
      validator: (data) =>
          optionalValue == null ? validator(data, null) : validator(data, optionalValue!),
    );
  }
}