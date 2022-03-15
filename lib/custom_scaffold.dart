import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const CustomScaffold({Key? key, required this.body, this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(children: [
        SvgPicture.asset(
          'assets/background.svg',
          height: (MediaQuery.of(context).size.height) + 20,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        body
      ]),
    );
  }
}
