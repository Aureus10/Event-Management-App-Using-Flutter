import 'dart:io';

import 'package:assignment/repositories/file_repository.dart';
import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {

  final FileRepository _fileRepository = FileRepository();

  Future<String?> uploadImage(File image, String email) async {
    return await _fileRepository.uploadImage(image, 'images/$email');
  }
}
