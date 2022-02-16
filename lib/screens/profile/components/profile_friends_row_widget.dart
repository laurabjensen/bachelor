import 'package:flutter/material.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class ProfileFriendsRow extends StatelessWidget {
  final Function() onSeeAll;

  const ProfileFriendsRow({required this.onSeeAll});

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
                  'Mine venner',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                GestureDetector(
                  onTap: onSeeAll,
                  child: Text('Se alle', style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => Card(
                            child: Center(
                          child: ProfileFriendWidget(),
                        )))),
          ],
        ));
  }
}
