import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class GroupDropDown extends StatelessWidget {
  final List<String>
      groups; // TODO: Måske skal dette være et objekt senere så medlemmer kan tilføjes til gruppen

  const GroupDropDown({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      //mode of dropdown
      mode: Mode.MENU,
      //to show search box
      showSearchBox: true,
      showSelectedItems: true,
      //list of dropdown items
      items: groups,
      onChanged: print,
      dropdownSearchDecoration: InputDecoration(labelText: 'Gruppe'),
      //show selected item
      selectedItem: "gruppe 1",
    );
  }
}
