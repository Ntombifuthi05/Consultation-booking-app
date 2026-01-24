import 'package:consultation/views/admin/admin_dashboard.dart';
import 'package:consultation/views/admin/admin_registration.dart';
import 'package:consultation/views/auth/admin_login_screen.dart';
import 'package:consultation/views/home_screem.dart';
import 'package:consultation/views/widgets/profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:consultation/models/consultation_model.dart';
import 'package:consultation/models/user_model.dart';
import 'package:consultation/views/auth/login_screen.dart';
import 'package:consultation/views/auth/registration_screen.dart';
import 'package:consultation/views/consultation/add_consultation_screen.dart';
import 'package:consultation/views/consultation/consultation_details_screen.dart';
import 'package:consultation/views/profile_page_screen.dart';

class RouteManager {
  // Public routes
  static const String loginPage = '/';
  static const String registrationPage = '/registration';
  static const String adminRegistration = '/admin-registration';
  static const String adminLogin = '/admin-login';
  static const String adminDashboard = '/admin-dashboard';

  
  // Protected routes
  static const String homePage = '/home';
  static const String profilePage = '/profile';
  static const String profileDetailsPage = '/profile/details';
  static const String addConsultationPage = '/add-consultation';
  static const String consultationDetailsPage = '/consultation-details';
  

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Public routes
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case registrationPage:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
        case adminLogin:
        return MaterialPageRoute(builder: (_) => AdminLoginScreen());
      case adminRegistration:
        return MaterialPageRoute(
          builder: (_) => AdminRegistrationScreen(),);
      // Protected routes
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePageScreen());
      case profileDetailsPage:
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ProfileDetailsScreen(user: user));
      case addConsultationPage:
        return MaterialPageRoute(builder: (_) => const AddConsultationScreen());
      case consultationDetailsPage:
        final consultation = settings.arguments as Consultation;
        return MaterialPageRoute(
          builder: (_) => ConsultationDetailsScreen(consultation: consultation),
        );
      
      default:
        throw const FormatException('Route not found');
    }
  }

  // Navigation helper methods
  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
  }

  static void goToRegistration(BuildContext context) {
    Navigator.pushNamed(context, registrationPage);
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
  }

  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, profilePage);
  }

  static void goToProfileDetails(BuildContext context, User user) {
    Navigator.pushNamed(context, profileDetailsPage, arguments: user);
  }

  static void goToAddConsultation(BuildContext context) {
    Navigator.pushNamed(context, addConsultationPage);
  }

  static void goToConsultationDetails(
      BuildContext context, Consultation consultation) {
    Navigator.pushNamed(context, consultationDetailsPage, arguments: consultation);
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}