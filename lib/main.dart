import 'package:flutter/material.dart';

import 'screens/dashboard.dart';
import 'screens/login.dart';
import 'screens/signup.dart';


void main() => runApp(MaterialApp(
   title: 'Sign up',
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/signup': (context) => SignupScreen(),
      '/dashboard': (context) => Dashboard(),
    }
));
