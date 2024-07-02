import 'package:flutter/material.dart';
import 'package:assignment/theme/colors.dart';


class CustomizedFontStyle {
  static const headerTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );
  static const h2TextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static const h3TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const linkTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: CustomizedColors.linkColor,
    decoration: TextDecoration.underline,
    decorationColor: CustomizedColors.linkColor,
  );
}

class CustomizedFont {
  final String text;

  CustomizedFont({
    required this.text,
  });
}
