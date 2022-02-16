import 'package:flutter/material.dart';
import 'package:spejder_app/model/rank.dart';

class RankDropdown extends StatelessWidget {
  final List<Rank> ranks;
  final Rank rank;
  final Function(Rank?) onChanged;

  const RankDropdown({required this.ranks, required this.rank, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget getWidget() {
      return DropdownButton<Rank>(
        //value: value!.isEmpty ? null : value,
        underline: Container(),
        icon: Container(),
        hint: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xff377E62),
        ),

        //dropdownColor: theme.scaffoldBackgroundColor,
        onChanged: onChanged,
        alignment: Alignment.centerRight,
        items: ranks.map<DropdownMenuItem<Rank>>((rank) {
          return DropdownMenuItem<Rank>(
              value: rank,
              child: Text(
                rank.title,
                style: theme.primaryTextTheme.headline3,
              ));
        }).toList(),
      );
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Material(
            color: Colors.white,
            elevation: 10.0,
            shadowColor: Color.fromRGBO(0, 0, 0, 25),
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
                height: 51,
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: ' ',
                  readOnly: true,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(height: 0, fontSize: 16),
                    prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text(rank.title.isEmpty ? 'Rang' : rank.title)),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixIcon:
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 25, 0), child: getWidget()),
                    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ))));
  }
}
