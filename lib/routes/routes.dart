import 'package:assignment/app.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routesConfig = {
  '/': (context) => const SplashArt(),
  '/auth': (context) => const AuthStateWidget(),
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),

};