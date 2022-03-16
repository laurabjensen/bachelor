import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';

class FriendsActivityScreen extends StatefulWidget {
  @override
  State<FriendsActivityScreen> createState() => _FriendsActivityScreenState();
}

class _FriendsActivityScreenState extends State<FriendsActivityScreen> {
  late UserProfile currentUser;
  late UserProfile userProfile =
      ModalRoute.of(context)!.settings.arguments as UserProfile;

  @override
  void initState() {
    super.initState();
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      body: Container(),
    );
  }
}
