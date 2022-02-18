import 'dart:io';

import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final File? image;
  final Function() onPressed;
  final String name;

  const UserImageWidget(
      {Key? key,
      required this.image,
      required this.onPressed,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / 8;

    String getInitials() {
      var initials = '';
      name.split(' ').forEach((element) {
        if (element.isNotEmpty) {
          initials = initials + element[0].toUpperCase();
        }
      });
      return initials;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey,
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    image!,
                    width: size,
                    height: size,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff0dfdb4),
                      borderRadius: BorderRadius.circular(size)),
                  width: size,
                  height: size,
                  child: name.isEmpty
                      ? const Icon(Icons.camera_alt, color: Color(0xff292a3e))
                      : Center(
                          child: Text(
                          getInitials(),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff292a3e)),
                        )),
                ),
        ),
        TextButton(onPressed: onPressed, child: Text('Tilføj profilbillede'))
      ]),
    );
  }
}
