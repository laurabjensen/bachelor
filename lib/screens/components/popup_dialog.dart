import 'package:flutter/material.dart';

Future<bool> simpleChoiceDialog(BuildContext context, String question) async {
  if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(question),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Ja'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            SimpleDialogOption(
              child: Text('Nej'),
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
