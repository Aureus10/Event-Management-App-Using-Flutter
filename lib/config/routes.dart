import 'package:assignment/app.dart';
import 'package:assignment/screens/forgot_password_screen.dart';
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
import 'package:assignment/screens/faq.dart';
import 'package:assignment/screens/request_feedback.dart';
import 'package:assignment/screens/view_request.dart';
import 'package:assignment/screens/past_request.dart';
import 'package:assignment/screens/event_details_joined.dart';
import 'package:assignment/screens/event_details_edit.dart';
import 'package:assignment/screens/event_details_view.dart';
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
  '/forgotPassword': (_) => const ForgotPasswordScreen(),
  '/faq':  (_) => const FAQScreen(),
  '/request_feedback':  (_) => const RequestFeedbackScreen(),
  '/view_request':  (_) => const ViewRequestScreen(),
  '/past_request':  (_) => const PastRequestScreen(),
  '/event_details_joined':  (_) => const EventDetailsScreen(),
  '/event_details_edited':  (_) => const EventDetailsEditScreen(),
  '/event_details_view':  (_) => const EventDetailsViewScreen(),
};