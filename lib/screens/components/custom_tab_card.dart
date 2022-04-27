import 'package:flutter/material.dart';

class CustomTabCard extends StatelessWidget {
  final Function() onTap;
  final Widget child;

  const CustomTabCard({Key? key, required this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 70,
        width: 336,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white,
            child: Padding(padding: const EdgeInsets.only(left: 20, right: 20), child: child),
          ),
        ),
      ),
    );
  }
}
