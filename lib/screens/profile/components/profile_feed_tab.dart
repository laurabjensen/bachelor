import 'package:flutter/material.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/post/feed_widget.dart';

class ProfileFeedTab extends StatelessWidget {
  final List<Post> posts;
  final UserProfile userProfile;
  final UserProfile currentUser;
  final Function(bool isLiked, Post post) onTap;

  const ProfileFeedTab(
      {Key? key,
      required this.posts,
      required this.userProfile,
      required this.currentUser,
      required this.onTap})
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
          currentUser: currentUser,
          onTap: (isLiked) => onTap(isLiked, posts[index]),
        );
      },
    );
  }
}
