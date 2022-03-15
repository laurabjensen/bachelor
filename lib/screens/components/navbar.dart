import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final Widget widget;
  final EdgeInsets padding;

  const CustomNavBar({Key? key, required this.widget, required this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget,
        Padding(
          padding: padding,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}
