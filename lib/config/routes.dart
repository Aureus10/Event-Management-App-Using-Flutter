import 'package:assignment/app.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/organize_event_screen.dart';
import 'package:assignment/screens/signup_screen.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routesConfig = {
  '/': (_) => const SplashArt(),
  '/auth': (_) => const AuthStateWidget(),
  '/login': (_) => const LoginScreen(),
  '/signup': (_) => const SignupScreen(),
  '/home': (_) => const HomeScreen(),
  '/organize': (_) => const OrganizeEventScreen(),
  

};