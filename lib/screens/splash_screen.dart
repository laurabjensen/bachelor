import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff62A388),
      body: Center(child: Image.asset('assets/kløver_grøn-kopi.png')),
    );
  }
}
