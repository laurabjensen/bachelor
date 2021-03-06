import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/custom_dialog.dart';
import 'package:spejder_app/screens/profile/bloc/profile_bloc.dart';
import 'package:spejder_app/screens/profile/components/friend_button.dart';
import 'package:spejder_app/screens/profile/components/profile_feed_tab.dart';
import 'package:spejder_app/screens/profile/components/profile_tab.dart';
import 'package:spejder_app/screens/profile/components/profile_info_widget.dart';

import '../edit_profile/bloc/editprofile_bloc.dart';
import '../edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const ProfileScreen({Key? key, required this.userProfile}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late UserProfile currentUser;
  late ProfileBloc profileBloc;
  late TabController controller;
  /*ProfileBloc(userProfile: ModalRoute.of(context)!.settings.arguments as UserProfile);*/

  @override
  void initState() {
    super.initState();
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    profileBloc = ProfileBloc(userProfile: widget.userProfile);
    controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  void logout() async {
    if (await customDialog(
        context, 'Er du sikker på, at du ønsker at logge ud?')) {
      Navigator.pop(context);
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }
  }

  void deleteFriend(ProfileBloc bloc) async {
    if (await customDialog(context,
        'Er du sikker på at du vil fjerne ${bloc.state.userProfile.name} som veninde?')) {
      bloc.add(DeleteFriendPressed(currentUser));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder(
        bloc: profileBloc,
        builder: (context, ProfileState state) {
          return CustomScaffold(
            //backgroundColor: Color(0xff71A08A),
            appBar: CustomAppBar.personalProfileAppBar(
                title: state.userProfile.name,
                onEditProfilePressed: () => pushNewScreen(context,
                    screen: EditProfileScreen(
                        userprofile: state.userProfile,
                        editprofileBloc: EditprofileBloc(state.userProfile,
                            authenticationBloc:
                                BlocProvider.of<AuthenticationBloc>(context),
                            profileBloc: profileBloc)),
                    withNavBar: false),
                onLogoutPressed: () => logout(),
                //Vis kun edit profil hvis man er på sin egen profil
                showActions: widget.userProfile.id == currentUser.id),
            body: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        color: Color(0xff377E62),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: ProfileInfoWidget(
                                  userProfile: state.userProfile,
                                  onBadgesTap: () => controller.index = 1,
                                  onFriendsTap: () => controller.index = 2,
                                )),
                            state.userProfile.id == currentUser.id
                                ? Container()
                                : FriendButton(
                                    userProfile: state.userProfile,
                                    currentUser: currentUser,
                                    onSendFriendRequest: () => profileBloc.add(
                                        SendFriendRequestPressed(currentUser)),
                                    onCancelFriendRequest: () => profileBloc
                                        .add(CancelFriendRequest(currentUser)),
                                    onAcceptsFriendRequest: () => profileBloc
                                        .add(AcceptFriendRequestPressed(
                                            currentUser)),
                                    onRejectFriendRequest: () =>
                                        profileBloc.add(
                                      RejectFriendRequestPressed(currentUser),
                                    ),
                                    onDeleteFriend: () =>
                                        deleteFriend(profileBloc),
                                  ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ];
              },
              body: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xff377E62),
                    child: TabBar(
                      controller: controller,
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      labelStyle: theme.primaryTextTheme.headline1!
                          .copyWith(color: Colors.white),
                      tabs: const [
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
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        ProfileFeedTab(
                          userProfile: state.userProfile,
                          posts: state.posts,
                          currentUser: currentUser,
                          onTap: (isLiked, post) => profileBloc
                              .add(LikePostPressed(currentUser, post, isLiked)),
                        ),
                        ProfileTab(
                          userProfile: state.userProfile,
                          approvedBadges: state.posts
                              .map((e) => e.badgeRegistration)
                              .toList(),
                          friends: null,
                        ),
                        ProfileTab(
                            userProfile: state.userProfile,
                            approvedBadges: null,
                            friends: state.friends)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
