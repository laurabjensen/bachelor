import 'package:flutter/material.dart';
import 'package:spejder_app/model/rank.dart';

class RankDropdown extends StatelessWidget {
  final List<Rank> ranks;
  final Rank rank;
  final Function(Rank?) onChanged;

  RankDropdown({required this.ranks, required this.rank, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget getWidget() {
      return DropdownButton<Rank>(
        //value: value!.isEmpty ? null : value,
        underline: Container(),
        icon: Container(),
        hint: Text(
          rank.title.isEmpty ? 'Vælg' : rank.title,
          //style: theme.primaryTextTheme.bodyText2,
        ),
        //dropdownColor: theme.scaffoldBackgroundColor,
        onChanged: onChanged,
        alignment: Alignment.centerRight,
        items: ranks.map<DropdownMenuItem<Rank>>((rank) {
          return DropdownMenuItem<Rank>(
              value: rank,
              child: Text(
                rank.title,
                //style: theme.primaryTextTheme.bodyText1,
              ));
        }).toList(),
      );
    }

    return TextFormField(
      //validator: validator,
      //controller: controller,
      obscureText: true,
      obscuringCharacter: ' ',
      readOnly: true,
      textAlign: TextAlign.right,
      //style: theme.textTheme.bodyText1,
      decoration: InputDecoration(
        //fillColor: Color(0xff292a3e),
        errorStyle: TextStyle(height: 0, fontSize: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
          child: Text(
            'Rang',
            //style: theme.primaryTextTheme.bodyText1,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0, 0, 25, 0), child: getWidget()),
        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        focusColor: Colors.grey,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
