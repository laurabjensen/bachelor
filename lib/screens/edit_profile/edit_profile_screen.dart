import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/edit_profile/bloc/editprofile_bloc.dart';
import 'package:spejder_app/screens/edit_profile/components/about_widget.dart';
import 'package:spejder_app/screens/edit_profile/components/user_image_widget.dart';
import 'package:spejder_app/screens/signup/components/group_dropdown.dart';
import 'package:spejder_app/screens/signup/components/rank_dropdown.dart';
import 'package:spejder_app/screens/signup/validators.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

// TODO: USE THEME ON TEXT
class _EditProfileScreenState extends State<EditProfileScreen> {
  late ThemeData theme;
  late EditprofileBloc editprofileBloc;
  late UserProfile userProfile =
      ModalRoute.of(context)!.settings.arguments as UserProfile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    editprofileBloc = EditprofileBloc();
  }

  void onUpdateButtonPress() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      editprofileBloc.add(UpdatePressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xff63A288),
      body: BlocListener(
          bloc: editprofileBloc,
          listener: (context, EditprofileState state) {
            if (state.editprofileStatus == EditprofileStateStatus.loading) {
              EasyLoading.show();
            } else if (state.editprofileStatus ==
                EditprofileStateStatus.failure) {
              EasyLoading.showError(state.failureMessage);
            } else if (state.editprofileStatus ==
                EditprofileStateStatus.success) {
              EasyLoading.showSuccess('Bruger opdateret');
              Navigator.pop(context);
            }
          },
          child: BlocBuilder(
              bloc: editprofileBloc,
              builder: (context, EditprofileState state) {
                return Center(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: 700,
                        decoration: BoxDecoration(
                            color: Color(0xffEEF2F3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  UserImageWidget(
                                      image: null,
                                      onPressed: () => null,
                                      name: state.name),
                                  LoginTextFormField(
                                      labelText: 'Navn',
                                      value: userProfile.name,
                                      obscureText: false,
                                      validator: Validators.validateNotNull,
                                      onChanged: (name) =>
                                          userProfile.copyWith(name: name),
                                      keyboardType: TextInputType.name),
                                  //TODO: FIKS HER SÅ DET BLIVER VÆLG FØDSELSDAG
                                  LoginTextFormField(
                                    labelText: 'Alder',
                                    value: userProfile.age.toString(),
                                    obscureText: false,
                                    validator: Validators.validateNotNull,
                                    onChanged: (age) => userProfile.copyWith(
                                        age: int.parse(age!)),
                                    keyboardType: TextInputType.number,
                                  ),
                                  AboutMeWidget(
                                    onChanged: (description) => null,
                                    validator: Validators.validateNotNull,
                                    value: '',
                                  ),
                                  GroupDropDown(
                                    groups: state.groups,
                                    selectedGroup: state.group,
                                    onChanged: (group) => editprofileBloc
                                        .add(GroupChanged(group)),
                                  ),
                                  RankDropdown(
                                      ranks: state.ranks,
                                      rank: state.rank,
                                      onChanged: (rank) => editprofileBloc
                                          .add(RankChanged(rank))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 15),
                                      child: SizedBox(
                                          width: 169,
                                          height: 51,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                onUpdateButtonPress(),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff377E62)),
                                            child: Text('Opdater bruger',
                                                style: theme.primaryTextTheme
                                                    .headline1),
                                          ))),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Fortryd',
                                        style: theme.primaryTextTheme.headline1!
                                            .copyWith(color: Colors.black),
                                      ))
                                ],
                              ),
                            ))));
              })),
    );
  }
}
