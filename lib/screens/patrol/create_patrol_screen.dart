import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/patrol/bloc/create_patrol_bloc.dart';
import 'package:spejder_app/screens/patrol/components/custom_selectable_grid.dart';
import 'package:spejder_app/screens/signup/components/rank_dropdown.dart';
import 'package:spejder_app/validators.dart';

import '../../custom_scaffold.dart';
import '../components/navbar.dart';

class CreatePatrolScreen extends StatefulWidget {
  final UserProfile userProfile;

  const CreatePatrolScreen({Key? key, required this.userProfile}) : super(key: key);

  @override
  State<CreatePatrolScreen> createState() => _CreatePatrolScreenState();
}

class _CreatePatrolScreenState extends State<CreatePatrolScreen> {
  late ThemeData theme;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late CreatePatrolBloc createPatrolBloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
    createPatrolBloc = CreatePatrolBloc(group: widget.userProfile.group);
  }

  void createPatrolPressed() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      createPatrolBloc
          .add(CreatePatrol(nameController.text, createPatrolBloc.state.selectedUserProfiles));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      appBar: CustomAppBar.basicAppBarWithBackButton(
        title: 'Opret ny patrulje',
        onBack: () => Navigator.pop(context),
      ),
      body: BlocConsumer(
          bloc: createPatrolBloc,
          listener: (context, CreatePatrolState state) {
            if (state.createPatrolStatus == CreatePatrolStateStatus.success) {
              EasyLoading.showSuccess('Patrulje oprettet');
              Navigator.pop(context);
            } else if (state.createPatrolStatus == CreatePatrolStateStatus.loading) {
              EasyLoading.show();
            }
          },
          builder: (context, CreatePatrolState state) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    widget.userProfile.group.name,
                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 24),
                  ),
                  state.userProfiles.isNotEmpty
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 20, 0, 4),
                                child: Text(
                                  'Tilføj patrulje navn',
                                  style: theme.primaryTextTheme.headline1!
                                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),

                                  // Date picker
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                                  child: LoginTextFormField(
                                      controller: nameController,
                                      labelText: '',
                                      value: null,
                                      obscureText: false,
                                      validator: Validators.validateNotNull,
                                      onChanged: (name) => null,
                                      /*onChanged: (name) => widget.userprofile
                                                        .copyWith(name: name),*/
                                      keyboardType: TextInputType.name),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 10, 0, 4),
                                child: Text(
                                  'Vælg patrulje medlemmer',
                                  style: theme.primaryTextTheme.headline1!
                                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),

                                  // Date picker
                                ),
                              ),
                              CustomSelectableGrid(
                                userProfiles: state.userProfiles,
                                selectedUserProfiles: state.selectedUserProfiles,
                                onTap: (user) =>
                                    createPatrolBloc.add(ToggleSelectedUserProfile(user)),
                              ),
                              state.selectedUserProfiles.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                                      child: Center(
                                        child: SizedBox(
                                          width: 200,
                                          height: 60,
                                          child: ElevatedButton(
                                            onPressed: () => createPatrolPressed(),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff377E62)),
                                            child: Text(
                                              'Opret patrulje med ${state.selectedUserProfiles.length} spejdere', // ${selectedList.length}
                                              style: theme.primaryTextTheme.headline1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                            'Ingen medlemmer mangler patrulje',
                            style: theme.primaryTextTheme.headline2,
                          ),
                        ),
                ],
              ),
            );

            /*Skal sættes på ellers brokker Ranks dropdown 
               sig grundet manglende elementer der ikke når at blive loadet*/
          }),
    );
  }
}
