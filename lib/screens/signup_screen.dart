import 'dart:io';

import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/file_provider.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/custom_input_fields.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/components/password_field.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // final TextEditingController _pass = TextEditingController();

  String? errorMessage = '';
  bool isFirstPage = true;
  final _formKey = GlobalKey<FormState>();

  // FOR TESTING PURPOSES ONLY
  // String? _username = 'username';
  // String _email = 'testing12@gmail.com';
  // String? _password = 'sample123!P';
  // int? _age = 12;
  // Gender _gender = Gender.female;
  // String? _contact = '1011101101';
  // File? _image;

  String? _username;
  String _email = '';
  String? _password;
  int? _age;
  Gender _gender = Gender.female;
  String? _contact;
  File? _image;

  void signUp(BuildContext ctx) {
    try {
      late ProfileModel newProfile;
      final FileProvider fileProvider =
          Provider.of<FileProvider>(ctx, listen: false);
      fileProvider
          .uploadImage(_image!, _email)
          .then((_) => {
                newProfile = ProfileModel(
                    type: UserType.user,
                    age: _age!,
                    username: _username!,
                    gender: _gender,
                    email: _email,
                    contact: _contact!,
                    creditScore: 100,
                    imageLink: fileProvider.imageUrl!,
                    status: AccountStatus.active)
              })
          .then((_) => {
                AuthService().createNewUser(
                    newProfile: newProfile, password: _password!, context: ctx)
              })
          .then((_) => {Navigator.of(ctx).pushReplacementNamed('/home')});
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(ctx).clearSnackBars();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Sign up failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstPage = [
      const Text(
        'Signup Step 1 out of 2',
        style: titleTextStyle,
      ),
      const VerticalEmptySpace(
        height: 20,
      ),
      CustomTextFormField(
        text: 'Username*',
        initialValue: _username,
        validator: emptyValidator(),
        actionOnChanged: (value) {
          _username = value;
        },
      ),
      const VerticalEmptySpace(),
      CustomTextFormField(
        text: 'Email*',
        initialValue: _email,
        validator: emailValidator(),
        actionOnChanged: (value) {
          _email = value;
        },
      ),
      const VerticalEmptySpace(),
      CustomTextFormField(
        text: 'Contact*',
        initialValue: _contact,
        validator: contactValidator(),
        actionOnChanged: (value) {
          _contact = value;
        },
      ),
      const VerticalEmptySpace(),
      PasswordField(
          text: 'New Password*',
          initialValue: _password,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
          }),
      const VerticalEmptySpace(),
      PasswordField(
        text: 'Confirm Password*',
        initialValue: _password,
        customValidator: confirmPasswordValidator(_password),
      ),
      const VerticalEmptySpace(
        height: 50,
      ),
      CustomActionButton(
          displayText: 'Next',
          actionOnPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                //add
                isFirstPage = false;
              });
            }
          }),
    ];
    List<Widget> secondPage = [
      const Text(
        'Signup Step 2 out of 2',
        style: titleTextStyle,
      ),
      const VerticalEmptySpace(
        height: 20,
      ),
      SelectImageField(actionOnPressed: (image) {
        setState(() {
          _image = image;
        });
      }),
      if (_image != null)
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          width: 100,
          height: 100,
          child: Image.file(_image!, height: 200, width: 200),
          // clipBehavior: Clip.none,
        ),
      Wrap(
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: CustomNumericalTextFormField(
                text: 'Age*',
                initialValue: _age,
                validator: emptyValidator(),
                actionOnChanged: (value) {
                  _age = int.parse(value);
                }),
          ),
          const HorizontalEmptySpace(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: CustomGenderTextFormField(
                initialValue: _gender,
                actionOnChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                }),
          ),
        ],
      ),
      const VerticalEmptySpace(
        height: 40,
      ),
      CustomActionButton(
          displayText: 'Sign Up',
          actionOnPressed: () {
            if (_formKey.currentState!.validate()) {
              // debugPrint("hello");
              signUp(context);
            }
          }),
    ];
    return Scaffold(
      appBar: HeaderBar(
        headerTitle: 'Create New Account',
        menuRequired: false,
        textStyle: largeTextStyle,
        customAction: isFirstPage
            ? null
            : () {
                setState(() {
                  isFirstPage = !isFirstPage;
                });
              },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,
              35, MediaQuery.of(context).size.width * 0.1, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: isFirstPage ? firstPage : secondPage,
                    ))
              ]),
        ),
      ),
    );
  }
}

class SelectImageField extends StatefulWidget {
  const SelectImageField({super.key, required this.actionOnPressed, this.text});

  final Function(File?) actionOnPressed;
  final String? text;

  @override
  State<SelectImageField> createState() => _SelectImageFieldState();
}

class _SelectImageFieldState extends State<SelectImageField> {
  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
    widget.actionOnPressed(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text ?? 'Pick an Image',
          style: mediumTextStyle,
        ),
        IconButton(
            onPressed: _pickImageFromGallery,
            icon: const Icon(
              Icons.drive_folder_upload,
              size: 40,
            ))
      ],
    );
  }
}
