import 'package:assignment/widgets/header_bar.dart';
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
      home: Scaffold(
        appBar: HeaderBar(headerTitle: "Hello world"),
        ),
    );
  }
}
