import 'package:assignment/models/request_model.dart'
    show BaseRequestModel, ReportModel;
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestRepository {
  final _requestCollection = FirebaseFirestore.instance.collection('requests');

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllRequests() =>
      _requestCollection.snapshots();

  Future<BaseRequestModel> getRequest(String id) async =>
      _requestCollection.doc(id).get().then((DocumentSnapshot doc) =>
          BaseRequestModel.fromMap(doc.id, doc.data() as Map<String, dynamic>));

  Future<bool> getBannedStatus(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _requestCollection
        .where('type', isEqualTo: 'Report')
        .where('userEmail', isEqualTo: email)
        .where('status', isEqualTo: 'Approved')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<ReportModel> requests = querySnapshot.docs.map((doc) {
        return ReportModel.fromMap(doc.id, doc.data());
      }).toList();

      requests = requests.where((request) {
        return request.date.add(Duration(days: request.days!))
            .isAfter(DateTime.now()) && request.date
            .isBefore(DateTime.now());
      }).toList();
      if (requests.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  Future<String> addRequest(BaseRequestModel request) async =>
      _requestCollection
          .add(request.toMap())
          .then((DocumentReference docRef) => docRef.id)
          .catchError((_) => '');

  Future<bool> updateRequest(BaseRequestModel request) async =>
      _requestCollection
          .doc(request.id)
          .update(request.toMap())
          .then((_) => true)
          .catchError((_) => false);

  Future<bool> deleteRequest(String id) async => _requestCollection
      .doc(id)
      .delete()
      .then((_) => true)
      .catchError((_) => false);
}
