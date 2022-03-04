import 'package:flutter/material.dart';
import 'package:spejder_app/model/group.dart';

class LeaderDropdown extends StatelessWidget {
  final List<Group> groups;
  final Group group;
  final Function(Group?) onChanged;

  const LeaderDropdown({required this.groups, required this.group, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Group? initialValue =
        group.id.isNotEmpty ? groups.firstWhere(((element) => element.id == group.id)) : null;

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
                    value: initialValue,
                    decoration: InputDecoration(
                        hintText: 'Leder',
                        //floatingLabelStyle: , //TODO: FIX HER
                        //hintStyle: theme.primaryTextTheme.headline4,
                        labelStyle: theme.primaryTextTheme.headline4,
                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        errorStyle: TextStyle(height: 0, fontSize: 16),
                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    items: groups.map<DropdownMenuItem<Group>>((rank) {
                      return DropdownMenuItem<Group>(
                          value: group,
                          child: Text(
                            group.name,
                            style: theme.primaryTextTheme.headline3,
                          ));
                    }).toList(),
                    onChanged: onChanged,
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff377E62),
                      ),
                    ),
                  ),
                ))));
  }
}
