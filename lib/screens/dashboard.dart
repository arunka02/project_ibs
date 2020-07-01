import 'package:flutter/material.dart';
import 'package:project_ibs/screens/login.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatar = Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Icon(Icons.tag_faces, size: 110, color: Colors.teal));

    final description = Column(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'WELCOME ASWAR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: SizedBox(
              height: 20,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Let your dreams take flight',
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    )),
              )),
        ),
      ],
    );

    final buttonLogout = FlatButton(
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.teal, fontSize: 16),
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ListView(
          // shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 50),
          children: <Widget>[
            Align(alignment: Alignment.topRight, child: buttonLogout),
            avatar,
            description
          ],
        ),
      ),
    ));
  }
}
