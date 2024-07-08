import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/services/auth.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/custom_input_fields.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/components/password_field.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? errorMessage = '';
  bool isFirstPage = true;
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password;
  late String _confirmPassword;
  late int _age;
  late Gender _gender;
  late String _contact;

  Future<void> signUp() async {
    try {
      await Auth()
          .createUserWithEmailAndPassword(email: _email, password: _password);

      ProfileModel newProfile = ProfileModel(
          id: _email,
          type: UserType.user,
          age: _age,
          username: _username,
          gender: _gender,
          email: _email,
          contact: _contact,
          creditScore: 100,
          imageLink: '',
          status: AccountStatus.active);

      await ProfileProvider().addProfile(newProfile);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Sign up failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstPage = [
      const Text(
        'Sign up',
        style: titleTextStyle,
      ),
      const VerticalEmptySpace(
        height: 20,
      ),
      CustomTextFormField(
        text: 'Username*',
        validator: emptyValidator(),
        actionOnChanged: (value) {
          _username = value;
        },
      ),
      const VerticalEmptySpace(),
      const Text(
        'Email*',
        style: mediumTextStyle,
      ),
      TextFormField(
        onChanged: (value) {
          _email = value;
        },
        decoration: const InputDecoration(
          hintText: '',
        ),
        validator: (value) {
          if (!value!.isValidEmail) {
            return "Invalid Email";
          }
          return null;
        },
      ),
      const VerticalEmptySpace(),
      const Text(
        'Contact*',
        style: mediumTextStyle,
      ),
      TextFormField(
        onChanged: (value) {
          _contact = value;
        },
        decoration: const InputDecoration(
          hintText: '',
        ),
        validator: (value) {
          if (!value!.isValidEmail) {
            return "Invalid Email";
          }
          return null;
        },
      ),
      const VerticalEmptySpace(),
      PasswordField(
          text: 'New Password*',
          onChanged: (value) {
            _password = value;
          }),
      const VerticalEmptySpace(),
      PasswordField(
          text: 'Confirm Password*',
          onChanged: (value) {
            _confirmPassword = value;
          }),
      const VerticalEmptySpace(),
      const VerticalEmptySpace(
        height: 40,
      ),
      CustomActionButton(
          displayText: 'Next',
          actionOnPressed: () {
            setState(() {
              isFirstPage = false;
            });
          })
    ];
    List<Widget> secondPage = [
      Row(
        children: [
          Expanded(
            child: CustomNumericalTextFormField(
                text: 'Age',
                validator: emptyValidator(),
                actionOnChanged: (value) {
                  _age = int.parse(value);
                }),
          ),
          Expanded(
            child: CustomGenderTextFormField(actionOnChanged: (value) {
              setState(() {
                _gender = value;
              });
            }),
          ),
        ],
      ),
    ];
    return Scaffold(
      appBar: const HeaderBar(
        headerTitle: 'Create New Account',
        menuRequired: false,
        textStyle: largeTextStyle,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: MediaQuery.of(context).size.width * 0.1),
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
      ),
    );
  }
}
