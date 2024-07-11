import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileRepository {

  final FirebaseStorage _fileRepository = FirebaseStorage.instance;

  Future<String?> uploadImage(File image, String path) async {

    try{
      Reference ref = _fileRepository.ref().child(path);
      TaskSnapshot taskSnapshot = await ref.putFile(image);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

}