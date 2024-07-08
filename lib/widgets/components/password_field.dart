import 'package:assignment/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:assignment/utils/form_vadidator.dart';

class PasswordField extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const PasswordField({super.key, required this.text, required this.onChanged});

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: mediumTextStyle,
        ),
        TextFormField(
          onChanged: widget.onChanged,
          obscureText: _isHidden,
          decoration: InputDecoration(
            // icon: Icon(Icons.password),
            hintText: 'examplePassword',
            // labelText: 'Passowrd*',
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
        )
      ],
    );
  }
}
