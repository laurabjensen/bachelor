import 'dart:io';

import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final File? imageFile;
  final String imageUrl;
  final Function() onPressed;

  const UserImageWidget({
    Key? key,
    required this.imageFile,
    required this.imageUrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 150;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey,
          child: imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    imageFile!,
                    width: size,
                    height: size,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        imageUrl,
                        width: size,
                        height: size,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff0dfdb4),
                          borderRadius: BorderRadius.circular(size)),
                      width: 170,
                      height: 170,
                      child: const Icon(Icons.camera_alt, color: Color(0xff292a3e))),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              'Tilføj profilbillede',
              style: theme.primaryTextTheme.headline4!.copyWith(color: Color(0xff007a54)),
            ))
      ]),
    );
  }
}
