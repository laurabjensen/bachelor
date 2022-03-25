import 'package:flutter/material.dart';

class ProfileNavbar extends StatelessWidget {
  final Function() onBack;
  final Function() onEditUser;
  final Function() onLogout;
  final bool isMyPage;

  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
  const ProfileNavbar(
      {required this.onBack,
      required this.onEditUser,
      required this.onLogout,
      required this.isMyPage});
  @override
  Widget build(BuildContext context) {
    Widget buttonRow() {
      if (isMyPage) {
        return Row(
          children: [
            IconButton(
                onPressed: onEditUser, icon: Icon(Icons.mode_edit_outline, color: Colors.black)),
            IconButton(onPressed: onLogout, icon: (Icon(logout, color: Colors.black))),
          ],
        );
      }
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ModalRoute.of(context)!.isFirst
            ? Container()
            : IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
        buttonRow()
      ],
    );
  }
}
