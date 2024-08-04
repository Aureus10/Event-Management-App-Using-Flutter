import 'package:assignment/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  final _profileCollection = FirebaseFirestore.instance.collection('users');

  Future<ProfileModel> getProfile(String email) async =>
      _profileCollection.doc(email).get().then((DocumentSnapshot doc) =>
          ProfileModel.fromMap(doc.data() as Map<String, dynamic>));

  Future<bool> addProfile(ProfileModel profile) async => _profileCollection
      .doc(profile.email)
      .set(profile.toMap())
      .then((_) => true)
      .catchError((_) => false);

  Future<bool> updateProfile(ProfileModel profile) async => _profileCollection
      .doc(profile.email)
      .update(profile.toMap())
      .then((_) => true)
      .catchError((_) => false);

  Future<String?> checkIfUserExist(String email) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (doc.data() != null) {
        return (doc.data() as Map<String, dynamic>)['username'];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // static Future<bool> deleteProfile(String email) => _profileCollection
  //     .doc(email)
  //     .delete()
  //     .then((_) => true)
  //     .catchError((_) => false);
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
