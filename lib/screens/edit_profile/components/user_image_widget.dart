import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    Widget noPictureWidget() {
      return Stack(
        children: [
          Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                color: Color(0xffFED105),
              )),
          Positioned(
              left: 3.5,
              top: 5,
              child: SvgPicture.asset(
                'assets/tørklæde_rød.svg',
                height: size - 10,
                width: size - 10,
                fit: BoxFit.scaleDown,
              )),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.grey,
            child: imageFile != null
                ? imageFile!.path.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          imageFile!,
                          width: size,
                          height: size,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : noPictureWidget()
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
                    : noPictureWidget()),
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
