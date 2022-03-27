import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/feed/feed_widget.dart';
import 'package:spejder_app/screens/profile/bloc/profile_bloc.dart';

class FeedScreen extends StatefulWidget {
  final UserProfile userProfile;

  const FeedScreen({Key? key, required this.userProfile}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late UserProfile currentUser;
  late ProfileBloc profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    profileBloc = ProfileBloc(userProfile: widget.userProfile);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder(
        bloc: profileBloc,
        builder: (context, ProfileState state) {
          return CustomScaffold(
            body: Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                //TODO: Skal have en anden liste
                itemCount: widget.userProfile.friends.length,
                itemBuilder: (context, index) {
                  return FeedWidget(
                    userProfile: currentUser,
                  );
                },
              ),
            ),
          );
        });
  }
}
