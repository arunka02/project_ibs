
import 'package:flutter/material.dart';
import 'login.dart';

class Dashboard extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    final avatar = Padding(
      padding: EdgeInsets.all(20),
        child: Hero(
        tag: 'hero',
        child: SizedBox(
          height: 160,
          child: Image.asset('assets/ac-arno-dorian.png'),
        )
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: 'Arno Victor Dorian (born 1768) was a member of the French Brotherhood of Assassins and a Master Assassin during the French Revolution. The only known son of Charles Dorian, an Assassin who was murdered by the Irish-American Templar Shay Cormac, Arno was then made a ward of Francois de la Serre, Grand Master of the French Rite of the Templar Order, and raised alongside his closest friend',
          style: TextStyle(color: Colors.black, fontSize: 20)
        ),
      ),
    );

    final buttonLogout = FlatButton(
      child: Text('Logout', style: TextStyle(color: Colors.black87, fontSize: 16),),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    );

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