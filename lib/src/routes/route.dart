import 'package:flutter/material.dart';
import 'package:fluttertest/src/screen/home_screen.dart';
import 'package:fluttertest/src/screen/login_screen.dart';
import 'package:fluttertest/src/screen/signup_screen.dart';
import 'package:fluttertest/src/screen/splash_screen.dart';

Map<String, WidgetBuilder> getApplicationRoute() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const LoginScreen(),
    '/sign_up': (BuildContext context) => const SignupScreen(),
    '/home': (BuildContext context) => const HomeScreen(),
    '/splash': (BuildContext context) => const SplashScreen(),
  };
}
