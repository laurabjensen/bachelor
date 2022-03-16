import 'package:flutter/material.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/user_profile.dart';

class LeaderDropdown extends StatelessWidget {
  final List<UserProfile> leaders;
  final UserProfile leader;
  final Function(UserProfile?) onChanged;
  final String? Function(UserProfile?) validator;

  const LeaderDropdown(
      {required this.leaders,
      required this.leader,
      required this.onChanged,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    UserProfile? initialValue =
        leader.id.isNotEmpty ? leaders.firstWhere(((element) => element.id == leader.id)) : null;

    return Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Material(
            color: Colors.white,
            elevation: 10.0,
            shadowColor: Color.fromRGBO(0, 0, 0, 25),
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
                height: 51,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    validator: (UserProfile? user) => validator(user),
                    value: initialValue,
                    decoration: InputDecoration(
                        hintText: 'Leder',
                        //floatingLabelStyle: , //TODO: FIX HER
                        hintStyle: theme.primaryTextTheme.headline4,
                        labelStyle: theme.primaryTextTheme.headline4,
                        contentPadding: initialValue != null
                            ? EdgeInsets.fromLTRB(0, 5, 0, 5)
                            : EdgeInsets.fromLTRB(12, 5, 0, 5),
                        errorStyle: TextStyle(height: 0, fontSize: 16),
                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    items: leaders.map<DropdownMenuItem<UserProfile>>((leader) {
                      return DropdownMenuItem<UserProfile>(
                          value: leader,
                          child: Text(
                            leader.name,
                            style: theme.primaryTextTheme.headline3,
                          ));
                    }).toList(),
                    onChanged: onChanged,
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff377E62),
                      ),
                    ),
                  ),
                ))));
  }
}
