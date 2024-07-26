import 'package:assignment/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  final _eventCollection = FirebaseFirestore.instance.collection('events');

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllEvents() =>
      _eventCollection.snapshots();

  // Stream<List<EventModel>> getEvents() =>
  //     _eventCollection.snapshots().map((snapshot) => snapshot.docs
  //         .map((doc) => EventModel.fromMap(doc.id, doc.data()))
  //         .toList());
  
  Future<EventModel> getEvent(String id) =>
          _eventCollection.doc(id).get().then((DocumentSnapshot doc) =>
          EventModel.fromMap(id, doc.data() as Map<String, dynamic>));

  // Stream<List<EventModel>> getEventsByStatus(
  //         EventStatus status) =>
  //     _eventCollection
  //         .where('status', isEqualTo: status.toString().split('.').last)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //             .map((doc) => EventModel.fromMap(doc.id, doc.data()))
  //             .toList());

  Future<String> addEvent(EventModel event) async {
    return _eventCollection
      .add(event.toMap())
      .then((DocumentReference docRef) => docRef.id);
  } 

  Future<bool> updateEvent(EventModel event) async => _eventCollection
      .doc(event.id)
      .update(event.toMap())
      .then((_) => true)
      .catchError((_) => false);

  Future<bool> deleteEvent(String id) async => _eventCollection
      .doc(id)
      .delete()
      .then((_) => true)
      .catchError((_) => false);
}
