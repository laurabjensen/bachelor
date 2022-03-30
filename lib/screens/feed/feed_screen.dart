import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/feed/bloc/feed_bloc.dart';
import 'package:spejder_app/screens/feed/feed_widget.dart';

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
    final theme = Theme.of(context);

    return BlocBuilder(
        bloc: feedBloc,
        builder: (context, FeedState state) {
          return CustomScaffold(
            appBar: CustomAppBar.withLogo(),
            body: Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return FeedWidget(
                    userProfile: state.posts[index].badgeRegistration.userProfile!,
                    post: state.posts[index],
                  );
                },
              ),
            ),
          );
        });
  }
}
