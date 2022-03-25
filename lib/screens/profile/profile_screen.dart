import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/badges_screen.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/custom_dialog.dart';
import 'package:spejder_app/screens/friends/friends_screen.dart';
import 'package:spejder_app/screens/profile/bloc/profile_bloc.dart';
import 'package:spejder_app/screens/profile/components/profile_badges_row_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_description_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_friends_row_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_info_widget.dart';
import 'package:spejder_app/screens/profile/components/profile_navbar.dart';

import '../edit_profile/bloc/editprofile_bloc.dart';
import '../edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const ProfileScreen({Key? key, required this.userProfile}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile currentUser;
  late ProfileBloc profileBloc;
  /*ProfileBloc(userProfile: ModalRoute.of(context)!.settings.arguments as UserProfile);*/

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    profileBloc = ProfileBloc(userProfile: widget.userProfile);
  }

  void logout() async {
    if (await customDialog(context, 'Er du sikker på, at du ønsker at logge ud?')) {
      Navigator.pop(context);
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder(
        bloc: profileBloc,
        builder: (context, ProfileState state) {
          return CustomScaffold(
              appBar: CustomAppBar.personalProficeAppBar(
                title: widget.userProfile.name,
                onEditProfilePressed: () => pushNewScreen(context,
                    screen: EditProfileScreen(
                        userprofile: state.userProfile,
                        editprofileBloc: EditprofileBloc(state.userProfile,
                            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                            profileBloc: profileBloc)),
                    withNavBar: false),
                onLogoutPressed: () => logout(),
              ),
              body: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: ProfileInfoWidget(
                              userProfile: state.userProfile,
                            ),
                          )
                        ]),
                      ),
                    ];
                  },
                  body: Column(
                    children: <Widget>[
                      TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        labelStyle: theme.primaryTextTheme.headline1!.copyWith(color: Colors.white),
                        tabs: [
                          Tab(
                            text: 'Aktivitet',
                          ),
                          Tab(
                            text: 'Mærker',
                          ),
                          Tab(
                            text: 'Veninder',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [ListView(), ListView(), ListView()],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}

/**
 * 
 * return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileInfoWidget(
                  userProfile: state.userProfile,
                ),
                Divider(
                  color: Color(0xff008060),
                  thickness: 2,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Om mig',
                            style: theme.primaryTextTheme.headline1,
                          ),
                        ),
                      ),
                      ProfileDescriptionWidget(
                        userProfile: state.userProfile,
                      ),
                      ProfileBadgesRow(
                        //! TODO: Når man trykker her skal badge screen vælge 'mine mærker' tab automatisk
                        onSeeAll: () => pushNewScreen(context,
                            screen:
                                BadgesScreen(userProfile: state.userProfile, initialTabIndex: 1),
                            withNavBar: false),
                        objects: state.badges,
                        headlineText: state.userProfile.id == currentUser.id
                            ? 'Mine mærker'
                            : '${state.userProfile.namePossessiveCase()} mærker',
                        noObjectsText: state.userProfile.id == currentUser.id
                            ? 'Du har endnu ikke registreret nogen mærker'
                            : '${state.userProfile.name} har endnu ikke registreret nogen mærker',
                        userProfile: state.userProfile,
                      ),
                      ProfileFriendsRow(
                        onSeeAll: () => pushNewScreen(context,
                            screen:
                                FriendsScreen(userProfile: state.userProfile, initialTabIndex: 1)),
                        objects: state.friends,
                        headlineText: state.userProfile.id == currentUser.id
                            ? 'Mine veninder'
                            : '${state.userProfile.namePossessiveCase()} veninder',
                        noObjectsText: state.userProfile.id == currentUser.id
                            ? 'Du har endnu ikke registreret nogen veninder'
                            : '${state.userProfile.name} har endnu ikke registreret nogen veninder',
                      ),
                    ],
                  ),
                ),
              ],
            );
 */
