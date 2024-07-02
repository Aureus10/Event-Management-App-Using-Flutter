import 'dart:io';

import 'package:assignment/components/buttons.dart';
import 'package:assignment/components/fonts.dart';
import 'package:assignment/components/password_field.dart';
import 'package:assignment/theme/colors.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          const HeaderText(text: 'Login'),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Email Address',
                //   style: h2TextStyle,
                // ),
                TextFormField(
                  decoration: const InputDecoration(
                    // icon: Icon(Icons.email),
                    hintText: 'example@gmail.com',
                    labelText: 'Email*',
                  ),
                  validator: (value) {
                    if (!value!.isValidEmail) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Password',
                  style: CustomizedFontStyle.h2TextStyle,
                ),
                const PasswordField(),
                const SizedBox(
                  height: 6,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CustomizedTextButton(
                    displayText: "Forgot Password?",
                    actionOnPressed: () {},
                  ),
                ]),

                const SizedBox(
                  height: 6,
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
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: CustomizedColors.buttonFontColor,
                  ),
                  backgroundColor: CustomizedColors.buttonColor),
              child: const Text(
                "Login",
                // style: TextStyle(
                //   color: CustomizedColors.buttonFontColor,
                // ),
              )),
          const SizedBox(
            height: 15,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(
                height: 2,
                thickness: 5,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              Text(
                'or login with',
                style: CustomizedFontStyle.h3TextStyle,
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    )));
  }
}
