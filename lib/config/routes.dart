import 'package:assignment/app.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/organize_event_screen.dart';
import 'package:assignment/screens/signup_screen.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:assignment/screens/profile_edit_screen.dart';
import 'package:assignment/screens/profile_view_screen.dart';
import 'package:assignment/screens/ban_user_screen.dart';
import 'package:assignment/screens/report_user_screen.dart';
import 'package:assignment/screens/event_calendar.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routesConfig = {
  '/': (_) => const SplashArt(),
  '/auth': (_) => const AuthStateWidget(),
  '/login': (_) => const LoginScreen(),
  '/signup': (_) => const SignupScreen(),
  '/home': (_) => const HomeScreen(),
  '/organize': (_) => const OrganizeEventScreen(),
  '/view_profile' : (_) => const ProfileViewScreen(),
  '/edit_profile' : (_) => const ProfileEditScreen(),
  '/report_user' : (_) => const ReportUserScreen(),
  '/ban_user' : (_) => const BanUserScreen(),
  '/event_calendar' : (_) => const EventCalendarScreen(),

};