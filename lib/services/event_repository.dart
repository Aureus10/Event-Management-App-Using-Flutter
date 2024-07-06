import 'package:assignment/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  static final _eventRepository =
      FirebaseFirestore.instance.collection('events');

  static Stream<List<EventModel>> getAllEvents() =>
      _eventRepository.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => EventModel.fromMap(doc.id, doc.data()))
          .toList());

  static Future<EventModel> getEvent(String id) async =>
      _eventRepository.doc(id).get().then((DocumentSnapshot doc) =>
          EventModel.fromMap(id, doc.data() as Map<String, dynamic>));

  static Future<bool> setEvent(EventModel event) async => _eventRepository
      .doc(event.id)
      .set(event.toMap())
      .then((_) => true)
      .catchError((_) => false);

  static Future<bool> addEvent(EventModel event) async => _eventRepository
      .add(event.toMap())
      .then((_) => true)
      .catchError((_) => false);

  static Future<bool> deleteEvent(String id) async => _eventRepository
      .doc(id)
      .delete()
      .then((_) => true)
      .catchError((_) => false);
}