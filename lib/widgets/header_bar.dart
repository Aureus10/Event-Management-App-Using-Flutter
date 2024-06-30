import 'package:assignment/theme/colors.dart';
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
              color: CustomizedColors.buttonFontColor,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          backgroundColor: CustomizedColors.backgroundColor,
          shadowColor: CustomizedColors.fontColor,
          elevation: 30,
        );
}
