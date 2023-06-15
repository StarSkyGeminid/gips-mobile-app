import 'package:flutter/material.dart';
import 'package:gips/screen/boarding/boarding_screen.dart';
import 'package:gips/screen/dashboard/dashboard_screen.dart';
import 'package:gips/screen/forgot_password/forgot_password_screen.dart';
import 'package:gips/screen/home/home_screen.dart';
import 'package:gips/screen/login/login_screen.dart';
import 'package:gips/screen/onboaring/onboarding_screen.dart';
import 'package:gips/screen/register/register_screen.dart';
import 'package:gips/screen/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/splash':
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case '/onboarding':
        return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.fade,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 500),
        );
      case '/boarding':
        return PageTransition(
          child: const BoardingScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );
      case '/login':
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.bottomToTop,
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 700),
        );
      case '/forgot_password':
        return PageTransition(
          child: const ForgotPasswordScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      case '/register':
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.bottomToTop,
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 700),
        );
      case '/dashboard':
        return PageTransition(
          child: const DashboardScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        );
      case '/home':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
