import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/group/bloc/group_bloc.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class MembersScreen extends StatefulWidget {
  final GroupBloc groupBloc;
  const MembersScreen({Key? key, required this.groupBloc}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late UserProfile userProfile;

  @override
  void initState() {
    userProfile = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    //groupBloc = GroupBloc(userProfile: userProfile);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar.basicAppBarWithBackButton(
          title: 'Medlemmer',
          onBack: () => Navigator.pop(context),
        ),
        body: BlocBuilder(
            bloc: widget.groupBloc,
            builder: (context, GroupState state) {
              return ListView(
                  physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: GridView.count(
                            physics:
                                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            children: List.generate(state.groupMembers.length, (index) {
                              return ProfileFriendWidget(
                                //badge: friends[index],
                                userProfile: state.groupMembers[index],
                              );
                            })))
                  ]);
            }));
  }
}
