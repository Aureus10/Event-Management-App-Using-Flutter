import 'package:assignment/theme/colors.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const h1TextStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
    );
    const h2TextStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    );
    const h3TextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage('assets/images/logo.png'),
            width: 180,
            height: 180,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Login',
            style: h1TextStyle,
            textAlign: TextAlign.left,
          ),
          // Form(child: ),
          const Text('Email Address', style: h2TextStyle),
          const Text('Password', style: h2TextStyle),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Show Password', style: h3TextStyle),
              Text('Forgot Password?', style: h3TextStyle)
            ],
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
              //     textStyle: const TextStyle(
              //       fontSize: 28,
              //       fontWeight: FontWeight.w600,
              //       color: CustomizedColors.buttonFontColor,
              //     ),
                  backgroundColor: CustomizedColors.buttonColor),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: CustomizedColors.buttonFontColor,
                ),
              ))
        ],
      ),
    )));
  }
}
