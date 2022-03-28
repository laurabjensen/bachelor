import 'package:flutter/material.dart';

class CustomAppBar {
  static basicAppBar({required String title, required bool showBackButton, Function()? onBack}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(45.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          leading: showBackButton
              ? Container()
              : IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back_ios)),
          actions: [],
        ));
  }

  static basicAppBarWithBackButton({required String title, Function()? onBack}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          leading: IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back_ios)),
        ));
  }

  static personalProficeAppBar(
      {required String title,
      required Function() onEditProfilePressed,
      required Function() onLogoutPressed}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          actions: [
            IconButton(
                onPressed: onEditProfilePressed,
                icon: Icon(Icons.mode_edit_outline, color: Colors.white)),
            IconButton(
                onPressed: onLogoutPressed,
                icon: (Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'), color: Colors.white))),
          ],
        ));
  }
}