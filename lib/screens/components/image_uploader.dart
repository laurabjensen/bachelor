import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  static Future<File> pickImage(
    ImageSource source,
  ) async {
    XFile? image;

    image = await ImagePicker().pickImage(source: source);

    if (image == null || image.path == '') {
      return File('');
    }

    return File(image.path);
  }

  /// If the [imageFilePath] is null or an empty path, a [FileSystemException] is thrown
  static Future<File?> cropImage(
    String? imageFilePath, {
    int maxHeight = 256,
    int maxWidth = 256,
    double aspectRatioX = 1.0,
    double aspectRatioY = 1.0,
    int compressQuality = 40,
  }) async {
    if (imageFilePath == null || imageFilePath.isEmpty) {
      throw FormatException('Can handle empty or null paths', imageFilePath);
    }

    if (Platform.isAndroid) return File(imageFilePath);

    return await ImageCropper().cropImage(
      sourcePath: imageFilePath,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      aspectRatio: CropAspectRatio(ratioX: aspectRatioX, ratioY: aspectRatioY),
      compressQuality: compressQuality,
      cropStyle: CropStyle.circle,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop profile image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        activeControlsWidgetColor: Colors.blue,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop profile image',
        doneButtonTitle: 'Done',
        cancelButtonTitle: 'Cancel',
      ),
    );
  }

  static Future<File?> cropImageWithoutRestrictions(String imageFilePath,
      {int maxHeight = 256,
      int maxWidth = 256,
      int compressQuality = 40}) async {
    if (imageFilePath.isEmpty) {
      throw FormatException('Can handle empty or null paths', imageFilePath);
    }

    if (Platform.isAndroid) return File(imageFilePath);

    return await ImageCropper().cropImage(
      sourcePath: imageFilePath,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      compressQuality: compressQuality,
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop profile image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop profile image',
        doneButtonTitle: 'Done',
        cancelButtonTitle: 'Cancel',
      ),
    );
  }

  /*static Future<File?> pickImageWithInstanCrop(ImageSource source,
      {File? originalFile,
      File? croppedFile,
      int maxHeight = 256,
      int maxWidth = 256,
      double aspectRatioX = 1.0,
      double aspectRatioY = 1.0,
      int compressQuality = 40}) async {
    var selected = await pickImage(source);
    
    var cropped = await cropImage(
      selected.path,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      aspectRatioX: aspectRatioX,
      aspectRatioY: aspectRatioY,
      compressQuality: compressQuality,
    );
    //if (originalFile != null) originalFile = selected;
    //if (croppedFile != null && ) croppedFile = File(cropped.path);
    return cropped;
  }*/

}
