import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/profile/components/profile_badge_widget.dart';

class ProfileBadgesRow extends StatelessWidget {
  final Function() onSeeAll;
  final String text;
  final List<Object> objects;

  const ProfileBadgesRow({required this.onSeeAll, required this.objects, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    child: Text('Se alle', style: TextStyle(fontSize: 15, color: Colors.white))),
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
                    itemBuilder: (BuildContext context, int index) => ProfileBadgeWidget(
                      badge: objects[index] as Badge,
                    ),
                  ),
                )),
          ],
        ));
  }
}
