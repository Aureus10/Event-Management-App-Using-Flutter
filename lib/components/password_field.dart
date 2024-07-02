import 'package:flutter/material.dart';
import 'package:assignment/utils/form_vadidator.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
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