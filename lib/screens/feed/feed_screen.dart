import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/feed/bloc/feed_bloc.dart';
import 'package:spejder_app/screens/feed/post/feed_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late UserProfile currentUser;
  late FeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    feedBloc = FeedBloc(userProfile: currentUser);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return BlocBuilder(
        bloc: feedBloc,
        builder: (context, FeedState state) {
          return CustomScaffold(
            appBar: CustomAppBar.withLogo(
              onTap: () async {
                // Delay to make sure the frames are rendered properly
                await Future.delayed(const Duration(milliseconds: 200));
                SchedulerBinding.instance?.addPostFrameCallback(
                  (_) {
                    _scrollController.animateTo(_scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
                  },
                );
                feedBloc.add(LoadInitialFeed());
              },
            ),
            body: RefreshIndicator(
              onRefresh: () async => feedBloc.add(LoadInitialFeed()),
              child: Builder(builder: (context) {
                if (state.posts.isNotEmpty) {
                  return ListView(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return FeedWidget(
                            userProfile: state.posts[index].badgeRegistration.userProfile!,
                            post: state.posts[index],
                            currentUser: currentUser,
                            onTap: (isLiked) =>
                                feedBloc.add(LikeToggled(state.posts[index], isLiked)),
                          );
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  );
                } else if (state.status == FeedStateLoadingStatus.loading) {
                  return Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        controller: _scrollController,
                      ),
                      SizedBox(height: 40),
                      CircularProgressIndicator()
                    ],
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, _) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Velkommen til din nye mærkeapp',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            ' Fremover vil du her kunne se dine veninders nye mærker. Dine mærker vil ligeledes vises her. ',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Kom i gang ved at registrere dit yndlingsmærke eller sende en venindeanmodning',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          );
        });
  }
}
