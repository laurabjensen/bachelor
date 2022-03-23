import 'package:flutter/material.dart';

Future<bool> denyDialog(BuildContext context, String question) async {
  final theme = Theme.of(context);
  if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Color(0xff63A288),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  child: Image.asset('assets/logo_m_skrift.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Er du sikker på, at du vil afvise mærket?',
                    style: theme.primaryTextTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ja',
                              style: theme.primaryTextTheme.headline1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Nej',
                              style: theme.primaryTextTheme.headline1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      })) {
    return true;
  } else {
    return false;
  }
}
