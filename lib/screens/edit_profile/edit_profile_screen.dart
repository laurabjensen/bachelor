import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

// TODO: USE THEME ON TEXT
class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff63A288),
        body: SafeArea(
            child: Column(children: [
          Stack(
            children: const [
              Text('Edit profile'),
            ],
          ),
        ])));
  }
}
