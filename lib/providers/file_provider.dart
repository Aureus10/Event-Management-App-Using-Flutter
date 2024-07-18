import 'dart:io';

import 'package:assignment/repositories/file_repository.dart';
import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {

  static final FileRepository _fileRepository = FileRepository();

  Future<String?> uploadProfileImage(File image, String email) async {
    return await _fileRepository.uploadFile(image, 'images/profile/$email');
  }

  static Future<String?> uploadEventImage(File image, String id) async {
    return await _fileRepository.uploadFile(image, 'images/event/$id');
  }
}
