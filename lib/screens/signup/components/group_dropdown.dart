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
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Material(
          color: Colors.white,
          elevation: 10.0,
          shadowColor: Color.fromRGBO(0, 0, 0, 25),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 51,
            child: DropdownSearch<String>(
              //mode of dropdown
              mode: Mode.MENU,
              //to show search box
              showSearchBox: true,
              showSelectedItems: true,
              //list of dropdown items
              items: groups.map((e) => e.name).toList(),
              onChanged: onChanged,

              dropdownButtonBuilder: (context) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xff377E62),
                    ));
              },
              dropdownSearchDecoration: InputDecoration(
                prefix: Text(selectedGroup.name.isEmpty ? 'Gruppe' : ''),
                isDense: true,
                //suffixIcon: Icon(Icons.arrow_downward),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
              //show selected item
              selectedItem: selectedGroup.name,
            ),
          ),
        ));
  }
}
