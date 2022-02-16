import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderCardWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onPressed;
  final String imgPath;

  const LeaderCardWidget({
    required this.color,
    required this.text,
    required this.onPressed,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: GestureDetector(
          onTap: onPressed,
          child: SizedBox(
            width: 336,
            height: 111,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(imgPath),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
