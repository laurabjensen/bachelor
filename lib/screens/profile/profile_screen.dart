import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/badge_widget.dart';
import 'package:spejder_app/screens/components/popup_dialog.dart';
import 'package:spejder_app/screens/profile/bloc/profile_bloc.dart';
import 'package:spejder_app/screens/profile/components/profile_badges_row_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_description_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_friends_row_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_info_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_navbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile currentUser;
  late UserProfile userProfile =
      ModalRoute.of(context)!.settings.arguments as UserProfile;
  late ProfileBloc profileBloc = ProfileBloc(userProfile: userProfile);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  void logout() async {
    if (await simpleChoiceDialog(
        context, 'Er du sikker på, at du ønsker at logge ud?')) {
      Navigator.pop(context);
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xff63A288),
      body: SafeArea(
        child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, ProfileState state) {
              return SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ProfileNavbar(
                        onBack: () => Navigator.pop(context),
                        onEditUser: () => Navigator.pushNamed(
                            context, AppRoutes.editProfileScreen,
                            arguments: userProfile),
                        onLogout: logout,
                        isMyPage: userProfile.id == currentUser.id,
                      ),
                      ProfileInfoWidget(
                        userProfile: userProfile,
                      ),
                    ],
                  ),
                  Divider(
                    color: Color(0xff178C6D),
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Om mig",
                        style: theme.primaryTextTheme.headline1,
                      ),
                    ),
                  ),
                  ProfileDescriptionWidget(),
                  ProfileBadgesRow(
                    //! TODO: Når man trykker her skal badge screen vælge 'mine mærker' tab automatisk
                    onSeeAll: () => Navigator.pushNamed(
                        context, AppRoutes.badgesScreen,
                        arguments: userProfile),
                    objects: state.badges,
                    text: userProfile.id == currentUser.id
                        ? 'Mine mærker'
                        : '${userProfile.namePossessiveCase()} mærker',
                  ),
                  ProfileFriendsRow(
                    onSeeAll: () =>
                        Navigator.pushNamed(context, AppRoutes.friendsScreen),
                    objects: state.friends,
                    text: userProfile.id == currentUser.id
                        ? 'Mine venner'
                        : '${userProfile.namePossessiveCase()} venner',
                  ),
                ],
              ));
            }),
      ),
    );
  }
}
