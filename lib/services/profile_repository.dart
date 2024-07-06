import 'package:assignment/models/event_model.dart';
import 'package:assignment/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  static final _profileRepository =
      FirebaseFirestore.instance.collection('users');

  static Future<ProfileModel> getProfile(String email) async =>
      _profileRepository.doc(email).get().then((DocumentSnapshot doc) =>
          ProfileModel.fromMap(doc.data() as Map<String, dynamic>));

  static Future<bool> setProfile(ProfileModel profile) async =>
      _profileRepository
          .doc(profile.email)
          .set(profile.toMap())
          .then((_) => true)
          .catchError((_) => false);

  static Future<bool> addProfile(ProfileModel profile) async =>
      setProfile(profile);

  // static Future<bool> deleteProfile(String email) => _profileRepository
  //     .doc(email)
  //     .delete()
  //     .then((_) => true)
  //     .catchError((_) => false);
}

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



// void findProductById(String productId) {
//   FirebaseFirestore.instance
//       .collection('products')
//       .where('productId', isEqualTo: productId)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       // Process the document that matches productId
//       print('Found product: ${doc.id}, ${doc['productName']}');
      
//       // You can terminate further processing here if needed
//     });
//   })
//   .catchError((error) {
//     print('Error finding product: $error');
//   });
// }

// Assume we have a specific product document with ID 'product123'
// String productId = 'product123';

// // Example: Query products with the same category as 'product123'
// var query = FirebaseFirestore.instance.collection('products')
//     .where('category', isEqualTo: 'Electronics');

// // Execute the query
// query.get().then((querySnapshot) {
//   // Process the query results
//   querySnapshot.docs.forEach((doc) {
//     // Access each document's data
//     print('Product name: ${doc['productName']}, Price: ${doc['price']}');
//   });
// }).catchError((error) {
//   print('Error fetching products: $error');
// });
// // Query all products where category contains 'Electronics'
// var query = FirebaseFirestore.instance.collection('products')
//     .where('category', arrayContains: 'Electronics');
// // Query all products where price is greater than 50
// var query = FirebaseFirestore.instance.collection('products')
//     .where('price', isGreaterThan: 50);
// // Query all products where category is 'Electronics'
// var query = FirebaseFirestore.instance.collection('products')
//     .where('category', isEqualTo: 'Electronics');
