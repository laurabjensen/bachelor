import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';
import 'package:spejder_app/screens/badges/components/badge_info_widget.dart';
import 'package:spejder_app/screens/badges/registration/bloc/badge_registration_bloc.dart';
import 'package:spejder_app/screens/badges/registration/components/date_picker_widget.dart';
import 'package:spejder_app/screens/badges/registration/components/leader_dropdown.dart';
import 'package:spejder_app/screens/badges/registration/components/read_more_button.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/edit_profile/components/about_widget.dart';
import 'package:spejder_app/validators.dart';

class RegisterBadgeScreen extends StatefulWidget {
  final BadgeSpecific badgeSpecific;
  const RegisterBadgeScreen({Key? key, required this.badgeSpecific}) : super(key: key);

  @override
  State<RegisterBadgeScreen> createState() => _RegisterBadgeScreenState();
}

class _RegisterBadgeScreenState extends State<RegisterBadgeScreen> {
  late ThemeData theme;
  late TextEditingController descriptionController;
  late UserProfile userprofile;
  late BadgeRegistrationBloc badgeRegistrationBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userprofile = BlocProvider.of<AuthenticationBloc>(context).state.userProfile!;
    badgeRegistrationBloc = BadgeRegistrationBloc(userProfile: userprofile);
    descriptionController = TextEditingController();
  }

  void onPressed(BadgeRegistrationState state) {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      badgeRegistrationBloc.add(SendRegistrationPressed(
          badgeSpecific: widget.badgeSpecific, description: descriptionController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocBuilder(
        bloc: badgeRegistrationBloc,
        builder: (context, BadgeRegistrationState state) {
          return CustomScaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: CustomNavBar(
                padding: EdgeInsets.only(top: 10, left: 10),
                widget: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Spejder mærke i stort
                      Center(
                          child: BadgeInfoWidget(
                        badgeSpecific: widget.badgeSpecific,
                      )),

                      // Dato
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),

                        child: Text('Hvornår har du taget mærket?',
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(fontWeight: FontWeight.bold)),
                        // Date picker
                      ),
                      DatePickerWidget(
                        validator: Validators.validateDateNotNull,
                        date: state.date,
                        onChanged: (date) {
                          date != null ? badgeRegistrationBloc.add(DateChanged(date)) : null;
                        },
                      ),
                      // Leder
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text('Hvem er din leder?',
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      // Leder dropdown
                      state.leaders.isNotEmpty
                          ? LeaderDropdown(
                              validator: Validators.validateUserNotNull,
                              leaders: state.leaders,
                              leader: state.leader ?? UserProfile.empty,
                              onChanged: (leader) =>
                                  badgeRegistrationBloc.add(LeaderChanged(leader)))
                          : Center(
                              child: Text(
                              'Der er ingen ledere tilknyttet denne gruppe',
                              style: theme.primaryTextTheme.bodyText2,
                            )),
                      // Din beskrivelse
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text('Din beskrivelse',
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      // Beskrivelses felt
                      AboutMeWidget(
                          controller: descriptionController,
                          onChanged: (description) => null,
                          validator: null,
                          labelText: '', // TODO: STYLE
                          hintText: 'Skriv lidt om dit spejderliv' // TODO: STYLE,
                          ),
                      // Button leder godkendelse
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Center(
                          child: SizedBox(
                            width: 267,
                            height: 51,
                            child: ElevatedButton(
                              onPressed: () => onPressed(state),
                              style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Send til leder godkendelse',
                                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Button læs mere
                      ReadMoreButton(badgeSpecific: widget.badgeSpecific)
                    ],
                  ),
                ),
              ),
            ),
          ));
        });
  }
}
