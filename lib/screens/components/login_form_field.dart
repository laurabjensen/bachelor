import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String labelText;
  final String value;
  final bool obscureText;
  final String? Function(String?, String?) validator;
  final String? optionalValue;
  final TextInputType keyboardType;
  final Function(String?) onChanged;

  const LoginTextFormField(
      {Key? key,
      required this.labelText,
      required this.value,
      this.optionalValue,
      required this.obscureText,
      required this.validator,
      required this.keyboardType,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Material(
            color: Colors.white,
            elevation: 10.0,
            shadowColor: Color.fromRGBO(0, 0, 0, 25),
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
                height: 51,
                child: TextFormField(
                  //controller: TextEditingController(text: value),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    labelText: labelText,
                  ),
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  initialValue: value,
                  obscureText: obscureText,
                  validator: (data) => optionalValue == null
                      ? validator(data, null)
                      : validator(data, optionalValue!),
                ))));
  }
}
