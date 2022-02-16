import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';

class BadgeWidget extends StatelessWidget {
  final Badge badge;

  const BadgeWidget({Key? key, required this.badge}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Color(0xffEEF2F3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 85,
                width: 85,
                decoration:
                    BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                badge.name,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ));
  }
}
