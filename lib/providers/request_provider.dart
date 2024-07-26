import 'package:assignment/models/request_model.dart';
import 'package:assignment/repositories/request_repository.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  final RequestRepository _requestRepostiory = RequestRepository();

  List<BaseRequestModel> _requestList = [];

  List<BaseRequestModel> get events => _requestList;

  Future<void> getEvents() async {
    _requestRepostiory.getAllRequests().listen((snapshot) {
      _requestList = snapshot.docs
          .map((doc) => BaseRequestModel.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
  }

  Future<void> makeRequest(BaseRequestModel request) async {
    String id = await _requestRepostiory.addRequest(request);
    if (id != '') {
      _requestList.add(request.copyWith(id: id));
      notifyListeners();
    }
  }

  Future<void> updateEvent(BaseRequestModel request, int index) async {
    bool status = await _requestRepostiory.updateRequest(request);

    if (status) {
      _requestList[index] = request;
      notifyListeners();
    }
  }
}
