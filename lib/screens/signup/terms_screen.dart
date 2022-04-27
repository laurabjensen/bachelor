import 'package:flutter/material.dart';
import 'package:spejder_app/custom_scaffold.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final String pdfText = """
Ved at benytte appen og oprette en bruger accepter du vores regler og vilkår.

Vi opbevarer dine personlige oplysninger kun i forbindelse med din brug af appen.
Herunder billeder, navn, alder og andre personfølsomme oplysninger. Disse oplysninger vidergives ikke eller deles. 

...
""";

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff377E62),
          title:
              Text('Regler og Vilkår', style: theme.primaryTextTheme.headline1),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop('User Agreed');
                    //agree = true;
                  },
                  child: Text(
                    'Accepter',
                    style: theme.primaryTextTheme.headline1!
                        .copyWith(fontSize: 15),
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              pdfText,
              style: theme.primaryTextTheme.headline1!
                  .copyWith(fontSize: 15, color: Colors.black),
            ),
          ),
        ));
  }
}
