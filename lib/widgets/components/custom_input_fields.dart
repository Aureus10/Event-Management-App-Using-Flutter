import 'package:assignment/models/profile_model.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.text,
      required this.validator,
      required this.actionOnChanged,
      this.hintText});

  final String text;
  final String? Function(String?)? validator;
  final Function(String) actionOnChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: mediumTextStyle,
        ),
        TextFormField(
          onChanged: actionOnChanged,
          decoration: InputDecoration(hintText: hintText ?? ''),
          validator: validator,
        )
      ],
    );
  }
}

class CustomNumericalTextFormField extends StatelessWidget {
  const CustomNumericalTextFormField(
      {super.key,
      required this.text,
      required this.validator,
      required this.actionOnChanged,
      this.hintText});

  final String text;
  final String? Function(String?)? validator;
  final Function(String) actionOnChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: mediumTextStyle,
        ),
        TextFormField(
          onChanged: actionOnChanged,
          decoration: InputDecoration(hintText: hintText ?? ''),
          validator: validator,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        )
      ],
    );
  }
}

class CustomGenderTextFormField extends StatefulWidget {
  const CustomGenderTextFormField({super.key, required this.actionOnChanged});

  final void Function(Gender) actionOnChanged;

  @override
  State<CustomGenderTextFormField> createState() =>
      _CustomGenderTextFormFieldState();
}

class _CustomGenderTextFormFieldState extends State<CustomGenderTextFormField> {
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Gender*',
          style: mediumTextStyle,
        ),
        DropdownButton(
          items: Gender.values.map((Gender gender) {
            return DropdownMenuItem<Gender>(
              value: gender,
              child: Text(gender.toString().split('.').last),
            );
          }).toList(),
          onChanged: (Gender? gender) {
            setState(() {
              selectedGender = gender;
            });
            if (selectedGender != null) {
              widget.actionOnChanged(selectedGender!);
            }
          },
          value: selectedGender,
        )
      ],
    );
  }
}
