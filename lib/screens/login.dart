import 'package:flutter/material.dart';
import './dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidden = true;
  var formKey = GlobalKey<FormState>();
  String email;
  String password;

  void _toggleVisibility() {
    setState(() {
      hidden = !hidden;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Icon(Icons.account_circle, size: 135, color: Colors.teal));

    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email id is Required';
          }
          if (!RegExp(
              r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        onSaved: (String value) {
          email = value;
        },
        decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email, color: Colors.teal),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
      ),
    );

    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty || value.length < 4) {
            return "Please enter the password with min 5 letters";
          }
        },
        onSaved: (String value) {
          password = value;
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock, color: Colors.teal),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon: hidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          ),
        ),
      ),
    );
    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('Login',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.teal,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: ()
          // print(emailController.text+' ssssssss' +passwordController.text);
          {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              if (emailController.text.toString() == 'aswar@ibsplc.com') {
                if (passwordController.text.toString() == 'aswar') {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                }
              } else {
                print('herer');
              }
            }
          },
        ),
      ),
    );

    final buttonForgotPassword = FlatButton(
        child: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.teal, fontSize: 16),
        ),
        onPressed: null);

    final buttonSignUp = Container(
      child: Padding(
        padding: EdgeInsets.only(left: 50),
        child: Row(children: <Widget>[
          Text("Don't have an account?",
              style: TextStyle(color: Colors.teal, fontSize: 14)),
          FlatButton(
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.teal, fontSize: 16),
              ),
              onPressed: null)
        ]),
      ),
    );

    /*final buttonSignUp = FlatButton(
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.teal, fontSize: 16),
      ),
      onPressed: null,
    );*/

    return SafeArea(
        child: Scaffold(
          body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    logo,
                    inputEmail,
                    inputPassword,
                    buttonLogin,
                    buttonForgotPassword,
                    buttonSignUp
                  ],
                ),
              )),
        ));
  }
}
