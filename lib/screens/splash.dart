import 'package:flutter/material.dart';

class SplashArt extends StatelessWidget {
  const SplashArt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.jpg'),
          width: 288,
          height: 288,
        ),
      ),
    );
  }
}
