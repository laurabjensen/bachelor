import 'package:flutter/material.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/navbar.dart';

class LeaderScreen extends StatefulWidget {
  final UserProfile userProfile;

  const LeaderScreen({Key? key, required this.userProfile}) : super(key: key);
  @override
  _LeaderScreenState createState() => _LeaderScreenState();
}

class _LeaderScreenState extends State<LeaderScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 60, left: 10),
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Text(
                  widget.userProfile.name,
                  style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                ),
                Text(
                  widget.userProfile.group.name,
                  style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 70,
                    width: 336,
                    child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.approveBadgesScreen),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Godkend mærker',
                                  style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 20),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 70,
                    width: 336,
                    child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.createPatrolScreen,
                            arguments: widget.userProfile),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Registrer patrulje',
                                  style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
