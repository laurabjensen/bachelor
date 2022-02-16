import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';

class ProfileFriendWidget extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileFriendWidget({Key? key, required this.userProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.profileScreen, arguments: userProfile),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration:
                    BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
              ),
              Text(
                userProfile.name,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
