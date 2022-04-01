import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar {
  static basicAppBar({required String title, required bool showBackButton, Function()? onBack}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          leading: showBackButton
              ? IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back_ios, color: Colors.white))
              : Container(),
          actions: const [],
        ));
  }

  static appbarWithDelete({required String title, Function()? onDelete}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(45.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          actions: [
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete_outline, color: Colors.white))
          ],
        ));
  }

  static basicAppBarWithBackButton({required String title, Function()? onBack}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          leading: IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ));
  }

  static personalProfileAppBar(
      {required String title,
      required Function() onEditProfilePressed,
      required Function() onLogoutPressed,
      required bool showActions}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
        child: AppBar(
          elevation: 0,
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          actions: showActions
              ? [
                  IconButton(
                      onPressed: onEditProfilePressed,
                      icon: Icon(Icons.mode_edit_outline, color: Colors.white)),
                  IconButton(
                      onPressed: onLogoutPressed,
                      icon: (Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                          color: Colors.white))),
                ]
              : [],
        ));
  }

  static withTabBar(
      {required String title, required PreferredSizeWidget bottom, List<Widget>? actions}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: AppBar(
          title: Text(title),
          backgroundColor: Color(0xff377E62),
          foregroundColor: Colors.white,
          bottom: bottom,
          actions: actions,
        ));
  }

  static withLogo({required Function() onTap}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              'assets/logo-lille-hvid.svg',
              color: Colors.white,
              height: 35,
            ),
          ),
          backgroundColor: Color(0xff377E62),
          foregroundColor: Colors.white,
        ));
  }
}
