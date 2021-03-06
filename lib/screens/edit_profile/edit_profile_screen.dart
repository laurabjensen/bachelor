import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/custom_dialog.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/edit_profile/bloc/editprofile_bloc.dart';
import 'package:spejder_app/screens/edit_profile/components/about_widget.dart';
import 'package:spejder_app/screens/edit_profile/components/user_image_widget.dart';
import 'package:spejder_app/screens/signup/components/group_dropdown.dart';
import 'package:spejder_app/screens/signup/components/rank_dropdown.dart';
import 'package:spejder_app/validators.dart';

import '../components/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userprofile;
  final EditprofileBloc editprofileBloc;

  const EditProfileScreen({Key? key, required this.userprofile, required this.editprofileBloc})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

// TODO: USE THEME ON TEXT
class _EditProfileScreenState extends State<EditProfileScreen> {
  late ThemeData theme;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController seniorityController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userprofile.name);
    ageController = TextEditingController(text: widget.userprofile.age.toString());
    seniorityController = TextEditingController(text: widget.userprofile.seniority.toString());
    descriptionController = TextEditingController(text: widget.userprofile.description);
  }

  void onUpdateButtonPress() {
    final currentFormState = formKey.currentState;
    if (currentFormState!.validate()) {
      widget.editprofileBloc.add(UpdatePressed(widget.userprofile.copyWith(
          name: nameController.text,
          age: int.parse(ageController.text),
          seniority: int.parse(seniorityController.text),
          description: descriptionController.text)));
    }
  }

  void onDeleteUserPressed() async {
    if (await customDialog(context,
        'Er du sikker p??, at du ??nsker at slette din bruger og alle data tilknyttet denne? Det vil ikke v??re muligt at genskabe den igen')) {
      () => null;
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return CustomScaffold(
      /*appBar: CustomAppBar.appbarWithDelete(
        title: 'Rediger profil',
        onDelete: () => onDeleteUserPressed(),
      ),*/
      appBar: CustomAppBar.basicAppBar(title: 'Rediger profil', showBackButton: false),
      body: BlocListener(
          bloc: widget.editprofileBloc,
          listener: (context, EditprofileState state) {
            if (state.editprofileStatus == EditprofileStateStatus.loading) {
              EasyLoading.show();
            } else if (state.editprofileStatus == EditprofileStateStatus.success) {
              EasyLoading.showSuccess('Bruger opdateret');
              Navigator.pop(context, state.userprofile);
            }
          },
          child: BlocBuilder(
              bloc: widget.editprofileBloc,
              builder: (context, EditprofileState state) {
                if (state.groups.isNotEmpty && state.ranks.isNotEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                        child: Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                            height: 750,
                            decoration: BoxDecoration(
                                color: Color(0xffEEF2F3), borderRadius: BorderRadius.circular(15)),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 140,
                                  ),
                                  LoginTextFormField(
                                      controller: nameController,
                                      labelText: 'Navn',
                                      value: null,
                                      obscureText: false,
                                      validator: Validators.validateNotNull,
                                      onChanged: (name) => null,
                                      /*onChanged: (name) => widget.userprofile
                                                .copyWith(name: name),*/
                                      keyboardType: TextInputType.name),
                                  //TODO: FIKS HER S?? DET BLIVER V??LG F??DSELSDAG
                                  LoginTextFormField(
                                    controller: ageController,
                                    labelText: 'Alder',
                                    value: null,
                                    obscureText: false,
                                    validator: Validators.validateIsOnlyIntAndNotNull,
                                    onChanged: (age) => null,
                                    /*onChanged: (age) => widget.userprofile
                                              .copyWith(age: int.parse(age!)),*/
                                    keyboardType: TextInputType.number,
                                  ),
                                  LoginTextFormField(
                                    controller: seniorityController,
                                    labelText: 'Antal ??rsstjerner',
                                    value: null,
                                    obscureText: false,
                                    validator:
                                        Validators.validateIsOnlyIntAndNotNullAndOnlyMax2Chars,
                                    onChanged: (senority) => null,
                                    /*onChanged: (age) => widget.userprofile
                                              .copyWith(age: int.parse(age!)),*/
                                    keyboardType: TextInputType.number,
                                  ),
                                  AboutMeWidget(
                                      controller: descriptionController,
                                      onChanged: (description) => null,
                                      validator: null,
                                      labelText: 'Om mig', // TODO: STYLE
                                      hintText: 'Skriv lidt om dit spejderliv' // TODO: STYLE,
                                      ),
                                  GroupDropDown(
                                    groups: state.groups,
                                    selectedGroup: state.group ?? widget.userprofile.group,
                                    onChanged: (group) =>
                                        widget.editprofileBloc.add(GroupChanged(group)),
                                  ),
                                  RankDropdown(
                                      ranks: state.ranks,
                                      rank: state.rank ?? widget.userprofile.rank,
                                      onChanged: (rank) =>
                                          widget.editprofileBloc.add(RankChanged(rank))),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                                      child: SizedBox(
                                          width: 169,
                                          height: 51,
                                          child: ElevatedButton(
                                            onPressed: () => onUpdateButtonPress(),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff377E62)),
                                            child: Text('Gem ??ndringer',
                                                style: theme.primaryTextTheme.headline1),
                                          ))),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, state.userprofile),
                                      child: Text(
                                        'Fortryd',
                                        style: theme.primaryTextTheme.headline1!
                                            .copyWith(color: Colors.black),
                                      )),
                                ],
                              ),
                            )),
                        Positioned(
                          top: 0,
                          left: (MediaQuery.of(context).size.width / 2) - (160 / 2),
                          child: UserImageWidget(
                              imageFile: state.imageFile,
                              imageUrl: widget.userprofile.imageUrl,
                              onPressed: () => imagePickerModal<File>(
                                          context: context,
                                          imageSelected: state.imageFile != null ||
                                              widget.userprofile.imageUrl.isNotEmpty)
                                      .then((value) {
                                    widget.editprofileBloc.add(NewImageFile(value));
                                  })),
                        ),
                      ],
                    )),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
