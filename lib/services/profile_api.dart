import 'package:assignment/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchProfile(String email) async {
  await FirebaseFirestore.instance.collection('users').doc(email).get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ProfileModel(
          id: data['id'],
          type: data['type'],
          age: data['age'],
          gender: data['gender'],
          email: data['email'],
          contact: data['contact'],
          eventHistory: data['eventHistory'],
          creditScore: data['creditScore'],
          imageLink: data['imageLink']);
    },
    onError: (e) => print("Error getting document : $e"),
  );
}

Future<void> newProfile(ProfileModel profile) async {
  Map<String, dynamic> profileData = profile as Map<String, dynamic>;

  FirebaseFirestore.instance
      .collection("users")
      .doc(profile.email)
      .set(profileData)
      .onError((error, stackTrace) => null);
}


