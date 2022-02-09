import 'package:flutter/material.dart';

class ProfileNavbar extends StatelessWidget {
  final Function() onBack;
  final Function() onEditUser;
  final Function() onLogout;

  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
  const ProfileNavbar({required this.onBack, required this.onEditUser, required this.onLogout});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        Row(
          children: [
            IconButton(
                onPressed: onEditUser, icon: Icon(Icons.mode_edit_outline, color: Colors.black)),
            IconButton(onPressed: onLogout, icon: (Icon(logout, color: Colors.black))),
          ],
        )
      ],
    );
  }
}
