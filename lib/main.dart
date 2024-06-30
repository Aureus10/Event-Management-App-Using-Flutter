import 'package:assignment/screens/splash_screen.dart';
import 'package:assignment/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Fredoka'),
      home: const SplashArt(),
      // home: const Scaffold(bottomNavigationBar: BottomMenu(), appBar: HeaderBar())
    );
  }
}
