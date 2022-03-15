import 'package:flutter/material.dart';

class ApproveBadgeButtonRow extends StatelessWidget {
  final Function() onAccept;
  final Function() onDeny;

  const ApproveBadgeButtonRow({Key? key, required this.onAccept, required this.onDeny})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button(String text, Color? textColor, BorderRadius borderRadius, Function() onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 50,
            width: 168,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Color(0xffEDF1F2),
                border: Border.all(color: Color(0xffDADEDF))),
            child: Center(
              child: Text(text,
                  style:
                      theme.primaryTextTheme.headline3!.copyWith(fontSize: 20, color: textColor)),
            )),
      );
    }

    return Row(
      children: [
        button('Godkend', null, BorderRadius.only(bottomLeft: Radius.circular(8)), onAccept),
        button('Afvis', Colors.red, BorderRadius.only(bottomRight: Radius.circular(8)), onDeny)
      ],
    );
  }
}
