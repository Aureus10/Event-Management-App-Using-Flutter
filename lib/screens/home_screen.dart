import 'package:assignment/widgets/bottom_navigation_bar.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderBar(headerTitle: 'GesT EMS'),
        bottomNavigationBar: const BottomMenu(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(child: CustomLink(displayText: 'testing',actionOnPressed: () {},)),
              Flexible(child: CustomLogoutButtonText()),
              Flexible(child: CustomLogoutButton()),
              Flexible(child: CustomActionButton(displayText: 'testing', actionOnPressed: () {},)),
            ],
          ),
        ));
  }
}
