import 'package:flutter/material.dart';
import 'package:login_signup_final/screens/dashboard.dart';
import 'package:login_signup_final/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: EdgeInsets.all(20),
        child: Hero(
        tag: 'hero',
        child: SizedBox(
          height: 160,
          child: Image.asset('assets/ac-logo.png'),
        )
      ),
    );

    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
        ),
      ),
    );

    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
        ),
      ),
    );

    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('Login',  style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          onPressed: () {
           // print(emailController.text+' ssssssss' +passwordController.text);
            if(emailController.text.toString()=='aswar'){
              if(passwordController.text.toString()=='aswar'){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
              }
             
            }else{
              print('herer');
            }
            
          },
        ),
      ),
    );

    final buttonForgotPassword = FlatButton(
      child: Text('Forgot Password', style: TextStyle(color: Colors.grey, fontSize: 16),),
      onPressed: null
    );

    final buttonSignUp = FlatButton(
      child: Text('Sign Up', style: TextStyle(color: Colors.grey, fontSize: 16),),
      onPressed: () {
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));
      }
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              logo,
              inputEmail,
              inputPassword,
              buttonLogin,
              buttonForgotPassword,
              buttonSignUp
            ],
          ),
        ),
      )
    );
  }
}