import 'package:assignment/theme/fonts.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Text(
        id,
        style: largeTextStyle,
      ),
    );
  }
}
