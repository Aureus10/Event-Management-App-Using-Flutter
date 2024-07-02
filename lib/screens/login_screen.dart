import 'package:assignment/theme/colors.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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

    const linkTextStyle = TextStyle(
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
          const Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              width: 180,
              height: 180,
            ),
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

          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email Address',
                  style: h2TextStyle,
                ),
                TextFormField(
                  validator: (value) {
                    if (!value!.isValidEmail) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),
                const Text('Password', style: h2TextStyle),
                TextFormField(
                  validator: (value) {
                    if (!value!.isValidPassword) {
                      return "Invalid Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Show Password', style: linkTextStyle),
                    Text('Forgot Password?', style: h3TextStyle)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successful')));
                }
              },
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
