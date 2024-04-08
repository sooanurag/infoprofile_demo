import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageFirebase {
  static Future<String?> upload(File file, {required String userid}) async {
    try {
      final ref = FirebaseStorage.instance.ref();
      var task = await ref.child(userid).putFile(file);
      return await task.ref.getDownloadURL();
    } catch (e) {
      debugPrint("Storage exception: $e");
      rethrow;
    }
  }
}
