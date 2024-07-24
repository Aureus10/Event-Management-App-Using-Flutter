// import 'package:assignment/app.dart';
// import 'package:assignment/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//     }
//   } catch (e) {
//     debugPrint("Error initializing Firebase: $e");
//   }

//   runApp(const MainApp());
// }

import 'package:assignment/screens/request_feedback.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RequestFeedbackScreen(),
    );
  }
}