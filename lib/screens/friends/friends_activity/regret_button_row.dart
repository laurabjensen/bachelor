import 'package:flutter/material.dart';

class RegretButtonRow extends StatelessWidget {
  final Function() onDeny;

  const RegretButtonRow({Key? key, required this.onDeny}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button(String text, Color? textColor, BorderRadius borderRadius,
        Function() onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 50,
            width: 336,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Color(0xffEDF1F2),
                border: Border.all(color: Color(0xffDADEDF))),
            child: Center(
              child: Text(text,
                  style: theme.primaryTextTheme.headline3!
                      .copyWith(fontSize: 20, color: textColor)),
            )),
      );
    }

    return Row(
      children: [
        button(
            'Annuller',
            Colors.red,
            BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)),
            onDeny)
      ],
    );
  }
}
