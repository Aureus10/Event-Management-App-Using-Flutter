import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment/theme/colors.dart';

class CustomLink extends StatelessWidget {
  const CustomLink(
      {super.key, required this.displayText, required this.actionOnPressed});

  final String displayText;
  final VoidCallback actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: actionOnPressed,
        child: Text(
          displayText,
          style: const TextStyle(
            fontSize: 14,
            color: CustomizedColors.linkColor,
            decoration: TextDecoration.underline,
            decorationColor: CustomizedColors.linkColor,
          ),
        ));
  }
}

class CustomLogoutButton extends StatelessWidget {
  const CustomLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      },
      icon: const Icon(Icons.logout),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(194, 235, 235, 235)),
        fixedSize: MaterialStateProperty.all<Size>(const Size(50, 50)),
      ),
    );
  }
}

class CustomLogoutButtonText extends StatelessWidget {
  const CustomLogoutButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            color: CustomizedColors.fontColor,
          ),
        ));
  }
}

class CustomActionButton extends StatelessWidget {
  const CustomActionButton(
      {super.key, required this.displayText, required this.actionOnPressed});

  final String displayText;
  final VoidCallback actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: actionOnPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomizedColors.buttonColor),
          minimumSize: MaterialStateProperty.all<Size>(
              Size(MediaQuery.of(context).size.width * 0.8, 60)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: const BorderSide(
                      color: CustomizedColors.selectedColor, width: 2),
                  borderRadius: BorderRadius.circular(18))),
        ),
        child: Text(
          displayText,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: CustomizedColors.buttonFontColor,
          ),
        ));
  }
}
