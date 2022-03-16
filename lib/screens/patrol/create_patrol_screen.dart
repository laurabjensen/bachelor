import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
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
  final CreatePatrolBloc createPatrolBloc = CreatePatrolBloc();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 60, left: 10),
        widget: BlocBuilder(
            bloc: createPatrolBloc,
            builder: (context, CreatePatrolState state) {
              if (state.ranks.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Text(
                          'Opret ny patrulje',
                          style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                        ),
                        Text(
                          widget.userProfile.group.name,
                          style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 17),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                          child: LoginTextFormField(
                              controller: nameController,
                              labelText: 'Navn på patrulje',
                              value: null,
                              obscureText: false,
                              validator: Validators.validateNotNull,
                              onChanged: (name) => null,
                              /*onChanged: (name) => widget.userprofile
                                                      .copyWith(name: name),*/
                              keyboardType: TextInputType.name),
                        ),
                        // TODO! USE DROPDOWN
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                          child: RankDropdown(
                              ranks: state.ranks,
                              rank: state.rank ?? widget.userProfile.rank,
                              onChanged: (rank) => createPatrolBloc.add(RankChanged(rank))),
                        ),
                        CustomSelectableGrid(),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: SizedBox(
                                width: 200,
                                height: 51,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, AppRoutes.signupScreen),
                                    style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                                    child: Text(
                                      'Opret patrulje med X spejdere', // ${selectedList.length}
                                      style: theme.primaryTextTheme.headline1,
                                    )))),
                      ],
                    ),
                  ),
                );
              }
              /*Skal sættes på ellers brokker Ranks dropdown 
               sig grundet manglende elementer der ikke når at blive loadet*/
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
