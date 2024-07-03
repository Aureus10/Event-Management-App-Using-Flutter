import 'package:flutter/material.dart';
import 'package:assignment/theme/colors.dart';

class CustomizedTextButton extends StatelessWidget {
  const CustomizedTextButton({super.key, required this.displayText, required this.actionOnPressed});

  final String displayText;
  final VoidCallback actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: actionOnPressed,
        child: Text(
          displayText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: CustomizedColors.linkColor,
            decoration: TextDecoration.underline,
            decorationColor: CustomizedColors.linkColor,
          ),
        ));
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

