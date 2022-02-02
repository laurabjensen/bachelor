import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:spejder_app/model/group.dart';

class GroupDropDown extends StatelessWidget {
  final List<Group> groups;
  final Group selectedGroup;
  final Function(String?) onChanged;

  const GroupDropDown(
      {Key? key, required this.groups, required this.selectedGroup, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      //mode of dropdown
      mode: Mode.MENU,
      //to show search box
      showSearchBox: true,
      showSelectedItems: true,
      //list of dropdown items
      items: groups.map((e) => e.name).toList(),
      onChanged: onChanged,
      dropdownSearchDecoration: InputDecoration(labelText: 'Gruppe', border: OutlineInputBorder()),
      //show selected item
      selectedItem: selectedGroup.name,
    );
  }
}
