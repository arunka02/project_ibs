import 'package:flutter/material.dart';
import 'package:ibs_signup/screens/dashboard.dart';
import 'package:ibs_signup/screens/login.dart';
import 'package:ibs_signup/screens/signup.dart';

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
