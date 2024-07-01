import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routesConfig = {
  '/splash': (context) => const SplashArt(),
  '/login': (context) => const LoginScreen(),

};