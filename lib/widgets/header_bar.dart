import 'package:flutter/material.dart';

class HeaderBar extends AppBar {
  final String headerTitle;
  HeaderBar({
    super.key,
    required this.headerTitle,
  }) : super(
          title: Text(
            headerTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          backgroundColor: const Color(0xff27a1ff),
          shadowColor: Colors.black,
          elevation: 30,
        );
}
