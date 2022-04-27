import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/components/chat_detail_page.dart';
import 'package:spejder_app/screens/feed/components/feed_profile_post_widget.dart';

class FeedWidgetTopbar extends StatelessWidget {
  final UserProfile userProfile;
  final Post post;

  const FeedWidgetTopbar({Key? key, required this.userProfile, required this.post})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        //Profile picture
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: FeedProfileWidget(
            userProfile: userProfile,
          ),
        ),

        // Name and Date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfile.name,
              style: theme.primaryTextTheme.headline3!.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              '${DateFormat.d().format(post.badgeRegistration.approvedAt!)}. ${DateFormat.MMMM('da').format(post.badgeRegistration.approvedAt!)} ${DateFormat.y().format(post.badgeRegistration.approvedAt!)}',
              style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        //Sikre at dots kører til højre
        Expanded(child: SizedBox()),
        //Dots
        /*GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatDetailPage();
            }));
          },
        ),*/
      ],
    );
  }
}
