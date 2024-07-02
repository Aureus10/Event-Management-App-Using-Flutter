import 'package:assignment/auth.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Fredoka'),
      // initialRoute: '/',
      // routes: routesConfig,
      home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("helloSplashART");
              return const SplashArt();
            }
            if (snapshot.hasData) {
              print("hello world");
              return const HomeScreen();
            }
            return const LoginScreen();
          })),
    );
  }
}
