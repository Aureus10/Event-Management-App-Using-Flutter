
import 'package:assignment/models/request_model.dart' show BaseRequestModel;
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestRepository {

  final _requestCollection = FirebaseFirestore.instance.collection('requests');

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllRequests() =>
      _requestCollection.snapshots();

  Future<BaseRequestModel> getRequest(String id) async =>
      _requestCollection.doc(id).get().then((DocumentSnapshot doc) =>
          BaseRequestModel.fromMap(doc.id ,doc.data() as Map<String, dynamic>));

  Future<String> addRequest(BaseRequestModel request) async =>
    _requestCollection
      .add(request.toMap())
      .then((DocumentReference docRef) => docRef.id)
      .catchError((_) => '');


  Future<bool> updateRequest(BaseRequestModel request) async => _requestCollection
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