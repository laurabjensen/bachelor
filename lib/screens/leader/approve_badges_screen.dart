import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/leader/bloc/leader_bloc.dart';
import 'package:spejder_app/screens/leader/components/approve_badge_widget.dart';
import 'package:spejder_app/screens/leader/components/dialog_deny.dart';

class ApproveBadgesScreen extends StatefulWidget {
  @override
  _ApproveBadgesScreenState createState() => _ApproveBadgesScreenState();
}

class _ApproveBadgesScreenState extends State<ApproveBadgesScreen> {
  late UserProfile userProfile;
  late LeaderBloc leaderBloc;

  @override
  void initState() {
    super.initState();
    userProfile =
        BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
  }

  void deny() async {
    if (await denyDialog(
        context, 'Er du sikker på, at du ønsker at logge ud?')) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    leaderBloc = ModalRoute.of(context)!.settings.arguments as LeaderBloc;
    final theme = Theme.of(context);

    return BlocListener(
        bloc: leaderBloc,
        listener: (context, LeaderState state) {
          if (state.registrationStatus ==
              LeaderBadgeRegistrationStatus.loading) {
            EasyLoading.show();
          } else if (state.registrationStatus ==
              LeaderBadgeRegistrationStatus.finished) {
            EasyLoading.dismiss();
          }
        },
        child: CustomScaffold(
          body: CustomNavBar(
            padding: EdgeInsets.only(top: 40, left: 10),
            widget: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Godkend mærker',
                        style: theme.primaryTextTheme.headline1!
                            .copyWith(fontSize: 30),
                      ),
                    ),
                    BlocBuilder(
                        bloc: leaderBloc,
                        builder: (context, LeaderState state) {
                          if (state.loadStatus == LeaderLoadStatus.loaded) {
                            if (state.badgeRegistrations.isNotEmpty) {
                              return Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          state.badgeRegistrations.length,
                                      itemBuilder: (context, index) {
                                        return ApproveBadgeWidget(
                                            badgeRegistration:
                                                state.badgeRegistrations[index],
                                            onAccept: () => leaderBloc.add(
                                                ApproveBadge(
                                                    state.badgeRegistrations[
                                                        index])),
                                            onDeny: () => deny());
                                        //leaderBloc.add(
                                        //DenyBadge(
                                        //   state.badgeRegistrations[
                                        //       index])));
                                      }));
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                    'Der ligger ingen mærker til godkendelse hos dig i øjeblikket!',
                                    textAlign: TextAlign.center,
                                    style: theme.primaryTextTheme.headline2!
                                        .copyWith(fontSize: 17)),
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
