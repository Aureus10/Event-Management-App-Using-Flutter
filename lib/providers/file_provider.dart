import 'dart:io';

import 'package:assignment/repositories/file_repository.dart';
import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {

  final FileRepository _fileRepository = FileRepository();

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  Future<void> uploadImage(File image, String email) async {
    final url = await _fileRepository.uploadImage(image, 'images/$email');
    if (url != null) {
      _imageUrl = url;
      notifyListeners();
    }
  }
}
