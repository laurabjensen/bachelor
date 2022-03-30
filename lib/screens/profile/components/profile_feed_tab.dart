import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/feed_widget.dart';

class ProfileFeedTab extends StatelessWidget {
  final List<Post> posts;
  final UserProfile userProfile;

  const ProfileFeedTab({Key? key, required this.posts, required this.userProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return FeedWidget(
          userProfile: userProfile,
          post: posts[index],
        );
      },
    );
  }
}
