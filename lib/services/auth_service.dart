import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createNewUser({
    required ProfileModel newProfile,
    required String password,
    required BuildContext context,
  }) async {
    if(!await Provider.of<ProfileProvider>(context, listen: false).addProfile(newProfile)) {
      debugPrint("FAILURE");
      return;
    };
    await createUserWithEmailAndPassword(email: newProfile.email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}