import 'package:flutter/material.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/validators.dart';

class RankDropdown extends StatelessWidget {
  final List<Rank> ranks;
  final Rank rank;
  final Function(Rank?) onChanged;

  const RankDropdown({required this.ranks, required this.rank, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Rank? initialValue =
        rank.id.isNotEmpty ? ranks.firstWhere(((element) => element.id == rank.id)) : null;

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
                    validator: Validators.validateRankNotNull,
                    value: initialValue,
                    decoration: InputDecoration(
                        hintText: 'Rang',
                        //floatingLabelStyle: , //TODO: FIX HER
                        hintStyle: theme.primaryTextTheme.headline4,
                        labelStyle: theme.primaryTextTheme.headline4,
                        contentPadding: initialValue != null
                            ? EdgeInsets.fromLTRB(0, 5, 0, 5)
                            : EdgeInsets.fromLTRB(10, 5, 0, 5),
                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    items: ranks.map<DropdownMenuItem<Rank>>((rank) {
                      return DropdownMenuItem<Rank>(
                          value: rank,
                          child: Text(
                            rank.title,
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
