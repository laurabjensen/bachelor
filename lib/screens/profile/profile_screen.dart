import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/popup_dialog.dart';
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
  late UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    userProfile = ModalRoute.of(context)!.settings.arguments as UserProfile;

    void logout() async {
      if (await simpleChoiceDialog(context, 'Er du sikker på at du ønsker at logge ud?')) {
        Navigator.pop(context);
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff63A288),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ProfileNavbar(
                  onBack: () => Navigator.pop(context),
                  onEditUser: () => Navigator.pushNamed(context, AppRoutes.editProfileScreen),
                  onLogout: logout,
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
            ProfileDescriptionWidget(),
            ProfileBadgesRow(
              //! TODO: Når man trykker her skal badge screen vælge 'mine mærker' tab automatisk
              onSeeAll: () => Navigator.pushNamed(context, AppRoutes.badgesScreen),
            ),
            ProfileFriendsRow(
              onSeeAll: () => Navigator.pushNamed(context, AppRoutes.friendsScreen),
            ),
          ],
        ),
      ),
    );
  }
}
