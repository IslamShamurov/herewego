import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoreService {
  static final _storage = FirebaseStorage.instance.ref();
  static const _folder = "post_images";

  static Future<String?> uploadImage(File image) async {
    String imgName = 'image_${DateTime.now()}';
    Reference firebaseStorageRef = _storage.child(_folder).child(imgName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot? taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;

  }
}
