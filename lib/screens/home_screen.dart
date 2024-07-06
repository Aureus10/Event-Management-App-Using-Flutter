import 'package:assignment/widgets/bottom_navigation_bar.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final firestore = FirebaseFirestore.instance;

  void addUser() {}

  void getUsers() async {
    QuerySnapshot querySnapshot = await firestore.collection('users').get();

    querySnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }

  void updateUser(String docId) {
    firestore
        .collection('users')
        .doc(docId)
        .update({'age': 31, 'email': 'john.updated@example.com'}).then(
            (_) => print('DocumentSnapshot updated'));
  }

  void deleteUser(String docId) {
    firestore
        .collection('users')
        .doc(docId)
        .delete()
        .then((_) => print('DocumentSnapshot deleted'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderBar(headerTitle: 'GesT EMS'),
        bottomNavigationBar: const BottomMenu(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(
                  child: CustomLink(
                displayText: 'testing',
                actionOnPressed: () {
                  addUser();
                },
              )),
              // Flexible(child: CustomLogoutButtonText()),
              // Flexible(child: CustomLogoutButton()),
              Flexible(
                  child: CustomActionButton(
                displayText: 'testing',
                actionOnPressed: () {
                  FirebaseFirestore.instance.collection('users').doc('testing123').set({
                    'name': 'John Doe',
                    'age': 30,
                    'email': 'john.doe@example.com'
                  });
                },
              )),
            ],
          ),
        ));
  }
}
