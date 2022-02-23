import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_uploader.dart';

Future<File> imageFromCamera() async {
  var image = await ImageUploader.pickImage(ImageSource.camera);
  if (image.path.isNotEmpty) {
    image = (await ImageUploader.cropImage(image.path)) ?? image;
  }
  return image;
}

Future<File> imageFromGallery() async {
  var image = await ImageUploader.pickImage(ImageSource.gallery);
  if (image.path.isNotEmpty) {
    image = (await ImageUploader.cropImage(image.path)) ?? image;
  }
  return image;
}

File getFile() {
  return File('');
}

Future<File?> imagePickerModal<File>(
    {required BuildContext context, required bool imageSelected}) {
  return showModalBottomSheet<File>(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              onTap: () => imageFromGallery()
                  .then((value) => Navigator.pop(context, value)),
              leading: const Icon(Icons.photo_library),
              title: const Text('Foto album'),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              onTap: () => imageFromCamera()
                  .then((value) => Navigator.pop(context, value)),
              leading: const Icon(Icons.photo_camera),
              title: const Text('Kamera'),
            ),
            imageSelected
                ? Column(
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      ListTile(
                        onTap: () => Navigator.pop(context, null),
                        leading: const Icon(Icons.remove),
                        title: const Text('Fjern billede'),
                      )
                    ],
                  )
                : Container(),
          ],
        ));
      });
}

class Tuple<T1, T2> {
  final T1 a;
  final T2 b;

  Tuple(this.a, this.b);
}
