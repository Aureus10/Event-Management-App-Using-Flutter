import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(headerTitle: 'Welcome'),
    );
  }
}