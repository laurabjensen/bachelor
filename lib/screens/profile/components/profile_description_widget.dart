import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';

class ProfileDescriptionWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileDescriptionWidget({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final theme = Theme.of(context);

    return Builder(builder: (context) {
      if (userProfile.description.isEmpty) {
        return Container();
      } else if (userProfile.description.length < 200) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Scrollbar(
                controller: controller,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      userProfile.description,
                      style: theme.primaryTextTheme.headline3!
                          .copyWith(height: 1.4, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Scrollbar(
            controller: controller,
            trackVisibility: true,
            child: SizedBox(
              height: 140,
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
    });
  }
}
