import 'package:flutter/material.dart';

class ProfileDescriptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: const [
            // TODO: USE THEME ON TEXT
            Text(
              '',
            )
          ],
        ),
      ),
    );
  }
}
