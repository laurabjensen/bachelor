import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {
  /*Future<String> addFileToStorage(File file, String id) async {
    var filename = basename(file.path);
    var ref = FirebaseStorage.instance.ref().child('profile_images/$id/$filename');
    var url = '';
    await ref.putFile(file).whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    return url;
  }*/

  Future<File?> getFileFromStorage(String imageUrl) async {
    File? file;
    if (imageUrl.isNotEmpty) {
      try {
        await FirebaseStorage.instance.refFromURL(imageUrl).getDownloadURL().then((url) async {
          var result = await _downloadFile(url);
          if (result.isNotEmpty) {
            file = File(result);
          } else {
            file = null;
          }
        });
      } on FirebaseException {
        file = null;
      }
    }
    return file;
  }

  Future<void> deleteFileInStorage(String imageUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> _downloadFile(String url) async {
    var httpClient = HttpClient();
    File file;
    var filePath = '';

    try {
      var fileName = basename(url).split('?').first;
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        final directory = await getApplicationDocumentsDirectory();
        filePath = '${directory.path}/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        //filePath = 'Error code: ' + response.statusCode.toString();
        filePath = '';
      }
    } catch (ex) {
      //filePath = 'Can not fetch url';
      filePath = '';
    }

    return filePath;
  }
}
