import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<TabItem<dynamic>> items;
  final int initialActiveIndex;
  final Function(int i) onTap;

  const CustomBottomNavBar(
      {Key? key, required this.items, required this.initialActiveIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: items,
      initialActiveIndex: initialActiveIndex, //optional, default as 0
      onTap: onTap,
      backgroundColor: Color(0xff377E62),
      elevation: 0,
      style: TabStyle.react,
    );
  }
}
