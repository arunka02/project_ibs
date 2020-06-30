import 'package:flutter/material.dart';
import 'package:login_signup_final/screens/login.dart';
import 'package:login_signup_final/screens/signup.dart';
import 'package:login_signup_final/screens/dashboard.dart';
void main() => runApp(MaterialApp(
   title: 'Sign up',
      theme: ThemeData(
        primarySwatch: Colors.teal,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/signup': (context) => SignupScreen(),
      '/dashboard': (context) => Dashboard(),
    }
));
