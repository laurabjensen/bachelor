import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/feed/components/chat_detail_page.dart';
import 'package:spejder_app/screens/feed/components/feed_widget_topbar.dart';
import 'package:spejder_app/screens/feed/components/like_button_widget.dart';
import 'package:spejder_app/screens/feed/post/bloc/post_bloc.dart';

class FeedWidget extends StatefulWidget {
  final Post post;
  final UserProfile userProfile;
  final UserProfile currentUser;
  final Function(bool isLiked) onTap;
  const FeedWidget(
      {Key? key,
      required this.post,
      required this.userProfile,
      required this.currentUser,
      required this.onTap})
      : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  late PostBloc postBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postBloc = PostBloc(post: widget.post);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder(
        bloc: postBloc,
        builder: (context, PostState state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 325,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FeedWidgetTopbar(userProfile: widget.userProfile, post: state.post),
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
                                image: Image.network(
                                        state.post.badgeRegistration.badgeSpecific.imageUrl)
                                    .image)),
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
                                LikeButtonWidget(
                                  currentUser: widget.currentUser,
                                  likeList: state.post.likes,
                                  onTap: widget.onTap,
                                ),
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
        });
  }
}
