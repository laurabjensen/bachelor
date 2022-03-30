import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/chat_detail_page.dart';
import 'package:spejder_app/screens/feed/feed_profile_post_widget.dart';
import 'package:spejder_app/screens/feed/like_button_widget.dart';

class FeedWidget extends StatelessWidget {
  final Post post;
  final UserProfile userProfile;
  const FeedWidget({Key? key, required this.post, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          width: 325,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
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
                        style: theme.primaryTextTheme.headline3!
                            .copyWith(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  //Sikre at dots kører til højre
                  Expanded(child: SizedBox()),
                  //Dots
                  GestureDetector(
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
                  ),
                ],
              ),
              Divider(
                color: Color(0xffDADEDF),
                indent: 8,
                endIndent: 8,
              ),
              //Badge
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              Image.network(post.badgeRegistration.badgeSpecific.imageUrl).image)),
                ),
              ),
              Container(
                height: 60,
                width: 325,
                decoration: BoxDecoration(
                    color: Color(0xffEDF1F2),
                    border: Border.all(
                      color: Color(0xffDADEDF),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
                      child: Text(
                        'Har taget mærket',
                        style: theme.primaryTextTheme.headline3!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LikeButtonWidget(),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.messenger_outline,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ChatDetailPage();
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
