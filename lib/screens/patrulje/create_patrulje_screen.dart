import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/components/login_form_field.dart';
import 'package:spejder_app/screens/signup/validators.dart';

import '../../custom_scaffold.dart';
import '../components/navbar.dart';

class CreatePatruljeScreen extends StatefulWidget {
  final UserProfile userProfile;

  const CreatePatruljeScreen({Key? key, required this.userProfile})
      : super(key: key);

  @override
  State<CreatePatruljeScreen> createState() => _CreatePatruljeScreenState();
}

class _CreatePatruljeScreenState extends State<CreatePatruljeScreen> {
  late ThemeData theme;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

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
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Text(
                  'Opret ny patrulje',
                  style:
                      theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                ),
                Text(
                  widget.userProfile.group.name,
                  style:
                      theme.primaryTextTheme.headline1!.copyWith(fontSize: 17),
                ),
                LoginTextFormField(
                    controller: nameController,
                    labelText: 'Navn på patrulje',
                    value: null,
                    obscureText: false,
                    validator: Validators.validateNotNull,
                    onChanged: (name) => null,
                    /*onChanged: (name) => widget.userprofile
                                                .copyWith(name: name),*/
                    keyboardType: TextInputType.name),
                // TODO! USE DROPDOWN
                Container(
                  height: 51,
                  width: 306,
                  color: Colors.white,
                ),
                /*RankDropdown(
                                      ranks: state.ranks,
                                      rank: state.rank ?? widget.userprofile.rank,
                                      onChanged: (rank) =>
                                          widget.editprofileBloc.add(RankChanged(rank))),*/
/*ListView(
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Udfordringsmærker',
                style: theme.primaryTextTheme.headline1,
              ),
            ),
             GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.56,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          itemBuilder: (context, index) {
            return GridItem(
                item: itemList[index],
                isSelected: (bool value) {
                  setState(() {
                    if (value) {
                      selectedList.add(itemList[index]);
                    } else {
                      selectedList.remove(itemList[index]);
                    }
                  });
                  print("$index : $value");
                },
                key: Key(itemList[index].rank.toString()));
          }),
          ],
        );*/
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                        width: 200,
                        height: 51,
                        child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.signupScreen),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff377E62)),
                            child: Text(
                              'Opret patrulje med X spejdere', // ${selectedList.length}
                              style: theme.primaryTextTheme.headline1,
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
