import 'package:flutter/material.dart';

Future<bool> simpleChoiceDialog(BuildContext context, String question) async {
  final theme = Theme.of(context);
  if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(question,
              style: theme.primaryTextTheme.headline1!.copyWith(color: Colors.black)),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                'Ja',
                style: theme.primaryTextTheme.headline3,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            SimpleDialogOption(
              child: Text(
                'Nej',
                style: theme.primaryTextTheme.headline3,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            )
          ],
        );
      })) {
    return true;
  } else {
    return false;
  }
}
