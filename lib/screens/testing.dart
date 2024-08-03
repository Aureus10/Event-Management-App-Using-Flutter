import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/header_bar.dart';
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

class ForUnitTesting extends StatelessWidget {
  const ForUnitTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(headerTitle: 'UnitTesting', menuRequired: false),
      body: Column(
        children: [
          CustomActionButton(displayText: '', actionOnPressed: () {Navigator.of(context).pushNamed('/home');}),
          CustomActionButton(displayText: '', actionOnPressed: () {Navigator.of(context).pushNamed('/home');}),
          CustomActionButton(displayText: '', actionOnPressed: () {Navigator.of(context).pushNamed('/home');}),
          CustomActionButton(displayText: '', actionOnPressed: () {Navigator.of(context).pushNamed('/home');}),
          CustomActionButton(displayText: '', actionOnPressed: () {Navigator.of(context).pushNamed('/home');}),
        ],
      ),
    );
  }
}
