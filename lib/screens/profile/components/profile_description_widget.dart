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
      child: Scrollbar(
        controller: controller,
        trackVisibility: true,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 46, 147, 128),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width,
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
                          style: theme.primaryTextTheme.headline3!
                              .copyWith(height: 1.4, color: Colors.white)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
