import 'package:flutter/material.dart';
import 'package:spejder_app/constants.dart';

class RankDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Rank>(
        value: Rank.smutte,
        items: Rank.values.map((e) => DropdownMenuItem<Rank>(child: Text(e.name))).toList(),
        onChanged: (rank) => null);
  }
}
