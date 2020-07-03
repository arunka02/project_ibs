import 'package:flutter/material.dart';
import 'package:project_ibs/models/users.dart';
import 'package:project_ibs/screens/signup.dart';
import './dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool passwordVisible = true;

@override
void initState() {
  passwordVisible = false;
}

class _LoginPageState extends State<LoginPage> {

  final _user = User();
  bool _obscureText = true;
  var formKey = GlobalKey<FormState>();
  String email;
  String password;
   bool _autoValidate = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _createDialogueBox(BuildContext context, String title, String msg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

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
          _user.email = value;
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
        obscureText: passwordVisible,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock, color: Colors.teal),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _toggle();
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
        controller: passwordController,
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return "Password is required";
          } else {
            if (value.length < 5) {
              return "Password must contain min 6 letters";
            }
          }
        },
        onSaved: (String value) {
         _user.password = value;
        },
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
              if (emailController.text.toString() == 'aswar@ibsplc.com' &&
                  passwordController.text.toString() == '123456') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              } else {
                _createDialogueBox(
                    context, "Alert", "Incorrect username or password");
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
      width: MediaQuery.of(context).size.width / 30,
      child: Padding(
        padding: EdgeInsets.only(left: 35),
        child: Row(
          children: <Widget>[
            Text("Don't have an account?",
                style: TextStyle(color: Colors.teal, fontSize: 14)),
            FlatButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ),
          ],
        ),
      ),
    );

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            autovalidate: _autoValidate,
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
      ),
    ));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
