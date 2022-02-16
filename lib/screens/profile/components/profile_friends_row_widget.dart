import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class ProfileFriendsRow extends StatelessWidget {
  final Function() onSeeAll;
  final String text;
  final List<Object> objects;

  const ProfileFriendsRow({required this.onSeeAll, required this.text, required this.objects});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                GestureDetector(
                  onTap: onSeeAll,
                  child: Text('Se alle', style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(
                height: 135,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: objects.length,
                    itemBuilder: (BuildContext context, int index) => ProfileFriendWidget(
                      userProfile: objects[index] as UserProfile,
                    ),
                  ),
                )),
          ],
        ));
  }
}
