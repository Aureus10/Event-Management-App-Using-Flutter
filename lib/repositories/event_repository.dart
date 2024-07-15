import 'package:assignment/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  final _eventRepository = FirebaseFirestore.instance.collection('events');

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllEvents() =>
      _eventRepository.snapshots();

  // Stream<List<EventModel>> getEvents() =>
  //     _eventRepository.snapshots().map((snapshot) => snapshot.docs
  //         .map((doc) => EventModel.fromMap(doc.id, doc.data()))
  //         .toList());

  // Stream<List<EventModel>> getEventsByStatus(
  //         EventStatus status) =>
  //     _eventRepository
  //         .where('status', isEqualTo: status.toString().split('.').last)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //             .map((doc) => EventModel.fromMap(doc.id, doc.data()))
  //             .toList());

  Future<bool> addEvent(EventModel event) async => _eventRepository
      .add(event.toMap())
      .then((_) => true)
      .catchError((_) => false);

  Future<bool> updateEvent(EventModel event) async => _eventRepository
      .doc(event.id)
      .update(event.toMap())
      .then((_) => true)
      .catchError((_) => false);

  Future<bool> deleteEvent(String id) async => _eventRepository
      .doc(id)
      .delete()
      .then((_) => true)
      .catchError((_) => false);
}
