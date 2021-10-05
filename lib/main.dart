import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 10,
                        blurRadius: 100,
                        offset: Offset(0,0),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(200, 80),
                      bottomLeft: Radius.elliptical(200, 80),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade900,
                        Colors.purple.shade400,
                      ],
                    ),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Smash Media",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            color: Colors.purple.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  Positioned(
                    top: 190,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple.shade100,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.purple, blurRadius: 20)
                          ],
                          shape: BoxShape.circle,
                          color: Colors.purple.shade100,
                          image: DecorationImage(
                            image: AssetImage('images/music.png'),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple.shade100,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.purple, blurRadius: 10)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            // fit: BoxFit.fitWidth,
                            image: AssetImage('images/hamburger.png'),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple.shade100,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.purple, blurRadius: 10)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/Search.png'),
                          )
                      ),
                    ),
                  ),
              ],
              ),
              SizedBox(
                height: 80,
              ),
              Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 100,
                      padding: EdgeInsets.all(55),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            spreadRadius: 10,
                            blurRadius: 100,
                            // offset: Offset(0,0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade900,
                            Colors.purple.shade400,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      child: Container(
                        width: 350,
                        height: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple,
                              spreadRadius: 10,
                              blurRadius: 100,
                              // offset: Offset(0,0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade100,
                              Colors.purple.shade200,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
