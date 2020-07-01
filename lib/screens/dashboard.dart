
import 'package:flutter/material.dart';
import 'package:project_ibs/screens/login.dart';

class Dashboard extends StatelessWidget {
@override
  Widget build(BuildContext context) {
  final avatar = Padding(
      padding:EdgeInsets.only(bottom:30),
      child: Icon(Icons.tag_faces,size:110,color: Colors.teal));


  final description = Padding(
      padding: EdgeInsets.only(left:100),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: 'WELCOME ASWAR',
          style: TextStyle(color: Colors.black, fontSize: 20,)
        ),
      ),
    );

    final buttonLogout = Container(child:Align(alignment:Alignment.topRight,
      child:FlatButton(
      child: Text('Logout', style: TextStyle(color: Colors.teal, fontSize: 16),),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    )));

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: buttonLogout),
              avatar,
              description
              
            ],
          ),
        ),
      )
    );
  }
}