import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: [
          SizedBox(
            height: 100,
          ),
          Positioned(
              child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/no_cover.png'),
            )),
          )),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              "Music Name",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          )
        ],
      )),
    );
  }
}
