import 'package:assignment/services/auth.dart';
import 'package:assignment/routes/routes.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // void initState() {
  //   Navigator.of(context).pushNamed('/splash');
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.of(context).pop();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Navigator.of(context).pushNamed('/splash');
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context).pop();
    // });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Fredoka'),
      initialRoute: '/',
      routes: routesConfig,
    );
  }
}

class AuthStateWidget extends StatelessWidget {
  const AuthStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const LoginScreen();
      }),
    );
  }
}
