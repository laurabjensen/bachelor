import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';

class ProfileDescriptionWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileDescriptionWidget({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          color: Colors.white,
          elevation: 10.0,
          shadowColor: Color.fromRGBO(0, 0, 0, 25),
          borderRadius: BorderRadius.circular(15),
          child: Scrollbar(
              controller: controller,
              isAlwaysShown: true,
              child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                          flex: 1,
                          child: SingleChildScrollView(
                            controller: controller,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(userProfile.description,
                                  style: theme.primaryTextTheme.headline3!.copyWith(height: 1.4)),
                            ),
                          )),
                    ],
                  )))),
    );
  }
}

/*TextFormField(
                controller: TextEditingController(text: userProfile.description),
                //initialValue: userProfile.description,
                readOnly: true,
                minLines: 7,
                maxLines: 7,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ), */

/*Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: const [
            // TODO: USE THEME ON TEXT
            Text(
              '',
            )
          ],
        ),
      ), */
