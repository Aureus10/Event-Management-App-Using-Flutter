import 'package:assignment/routes/routes.dart';
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
        // home: const SplashArt(),
    
        // home: const LoginScreen(),
        initialRoute: '/',
        routes: routesConfig,
        );
  }
}