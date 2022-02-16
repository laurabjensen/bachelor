import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children: [
            // Profile picture circle
            Positioned(
                left: 15,
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.white,
                  ),
                )),
            // Range circle
            Positioned(
              top: 120,
              left: 10,
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.pink,
                ),
              ),
            ),
            // Star
            Positioned(
              top: 100,
              left: 135,
              child: Icon(
                Icons.star,
                size: 70,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
