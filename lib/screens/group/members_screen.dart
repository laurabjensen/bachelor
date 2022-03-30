import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/group/bloc/group_bloc.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key, required bool withNavBar}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late UserProfile userProfile;
  late GroupBloc groupBloc;

  @override
  void initState() {
    userProfile =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    groupBloc = GroupBloc(userProfile: userProfile);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      appBar: CustomAppBar.basicAppBarWithBackButton(
        title: 'Medlemmer',
        onBack: () => Navigator.pop(context),
      ),
      body: ProfileFriendWidget(
        userProfile: userProfile,
      ),
    );
  }
}
