import 'dart:io';

import 'package:assignment/models/request_model.dart';
import 'package:assignment/providers/file_provider.dart';
import 'package:assignment/repositories/request_repository.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  final RequestRepository _requestRepostiory = RequestRepository();

  List<BaseRequestModel> _requestList = [];

  List<BaseRequestModel> get requests => _requestList;

  Future<void> getRequests() async {
    _requestRepostiory.getAllRequests().listen((snapshot) {
      _requestList = snapshot.docs
          .map((doc) => BaseRequestModel.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
  }

  Future<void> makeRequest(BaseRequestModel request, Map<String, File> supportingDocuments) async {
    String id = await _requestRepostiory.addRequest(request);

    Map<String, String> supportingDocs = {};

    if (supportingDocuments.isNotEmpty) {
      for (String fileName in supportingDocuments.keys) {
        String ? link = await FileProvider.uploadSupportingDoc(supportingDocuments[fileName]!, id, fileName);
        if (link != null) {
          supportingDocs[fileName] = link;
        }
      }
    }

    if (id != '') {
      await _requestRepostiory.updateRequest(request.copyWith(id: id, supportingDocs: supportingDocs));
    }
  }

  Future<void> updateRequest(BaseRequestModel request, int index) async {
    bool status = await _requestRepostiory.updateRequest(request);

    if (status) {
      _requestList[index] = request;
      notifyListeners();
    }
  }

  Future<BaseRequestModel> getRequest(String id) async {
    return await _requestRepostiory.getRequest(id);
  }
}
