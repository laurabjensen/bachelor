import 'package:flutter/material.dart';

class AboutMeWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?, String?) validator;
  final Function(String?) onChanged;

  const AboutMeWidget(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Material(
        elevation: 10.0,
        color: Colors.white,
        shadowColor: Color.fromRGBO(0, 0, 0, 25),
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 102,
          child: TextFormField(
            style: theme.primaryTextTheme.headline4,
            controller: controller,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                labelText: 'Om mig',
                hintText: 'Skriv om dig selv..',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle:
                    theme.primaryTextTheme.headline3!.copyWith(height: 0)),
            keyboardType: TextInputType.multiline,
            onChanged: onChanged,
            maxLines: 5,
            validator: (data) => validator(data, null),
          ),
        ),
      ),
    );
  }
}
