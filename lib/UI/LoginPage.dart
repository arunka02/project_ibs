import 'package:flutter/material.dart';
import 'package:project_ibs/UI/ValidateLogin.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(008080),
          fontFamily: "Ubuntu"
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidateLogin{

  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
        child:Form(
          key:formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70.0,),
            Icon(Icons.account_circle,size:100,color: Colors.teal,),
            SizedBox(height: 40.0,),
            buildTextEmail("Email"),
            SizedBox(height: 20.0,),
            buildTextPassword("Password"),
            SizedBox(height: 20.0,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            submitButton(),
            SizedBox(height: 10.0,),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    SizedBox(width: 10.0,),
                    Text("SIGN UP", style: TextStyle(color: Theme.of(context).primaryColor,))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildTextEmail(String hintText){
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

        prefixIcon: hintText == "Email" ? Icon(Icons.email):null,

      ),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
        );
  }

  Widget buildTextPassword(String hintText){
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == "Password" ? IconButton(
          onPressed: _toggleVisibility,
          icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        ) : null,
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }


  Widget submitButton() {
    return RaisedButton(
      color: Colors.teal,
      child: Text('LOGIN'),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();

        }
      },
    );
  }
}