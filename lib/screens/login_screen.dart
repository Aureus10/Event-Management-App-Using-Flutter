import 'package:assignment/theme/colors.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;

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
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    const linkTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: CustomizedColors.linkColor,
      decoration: TextDecoration.underline,
      decorationColor: CustomizedColors.linkColor,
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
                const Text('Password', style: h2TextStyle),
                const PassField(),
                const SizedBox(
                  width: 6,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: linkTextStyle,
                      )),
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
                style: h3TextStyle,
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

class PassField extends StatefulWidget {
  const PassField({super.key});

  @override
  State<PassField> createState() => PassFieldState();
}

class PassFieldState extends State<PassField> {
  bool _isHidden = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isHidden,
      decoration: InputDecoration(
        // icon: Icon(Icons.password),
        hintText: '',
        labelText: 'Passowrd*',
        suffixIcon: IconButton(
          icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                _isHidden = !_isHidden;
              },
            );
          },
        ),
      ),
      validator: (value) {
        if (!value!.isValidPassword) {
          return "Invalid Password";
        }
        return null;
      },
    );
  }
}
