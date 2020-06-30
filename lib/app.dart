import 'package:flutter/material.dart';
import 'package:ibs_signup/screens/home_material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     title: 'Sign up',
      theme: ThemeData(
        primarySwatch: Colors.teal,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomeMaterial(),

    );
      
    
  }
}