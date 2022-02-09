import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCardWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;

  const HomeCardWidget(
      {required this.color, required this.text, required this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: height ?? 265,
            width: width ?? 157,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: color,
              child: Center(
                  child: Text(
                text,
                style: GoogleFonts.barlow(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ));
  }
}
