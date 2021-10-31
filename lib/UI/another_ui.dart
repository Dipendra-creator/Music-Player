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
                clipBehavior: Clip.none,
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
                          offset: Offset(0, 0),
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
                          )),
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
                          )),
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
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 34, right: 34, top: 10),
                    height: 150,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            spreadRadius: 5,
                            blurRadius: 70,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade900,
                            Colors.purple.shade300,
                          ],
                          begin: Alignment.topCenter,
                        )),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 145, top: 14),
                          width: double.infinity,
                          child: Text(
                            "Song Name",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.purple.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 145),
                          width: double.infinity,
                          child: Text(
                            "Album Name",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purple.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 110),
                      height: 115,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            spreadRadius: 5,
                            blurRadius: 70,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    size: 35,
                                    color: Colors.purple.shade500,
                                  ),
                                  onPressed: () {
                                    print('Rewind');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.play_arrow,
                                    size: 35,
                                    color: Colors.purple.shade500,
                                  ),
                                  onPressed: () {
                                    print('Play');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fast_forward,
                                    size: 35,
                                    color: Colors.purple.shade500,
                                  ),
                                  onPressed: () {
                                    print('Forward');
                                  },
                                ),
                              ),
                              SizedBox(
                                // height: 20,
                                width: 10,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 71, bottom: 10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.stop,
                                    size: 45,
                                    color: Colors.purple.shade500,
                                  ),
                                  onPressed: () {
                                    print('Stop');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 39,
                    child: Container(
                      padding: EdgeInsets.all(55),
                      height: 135,
                      width: 135,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple.shade100,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.shade100,
                            blurRadius: 20,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Colors.purple.shade100,
                        image: DecorationImage(
                            image: AssetImage('images/music.png')),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.shade100,
                              blurRadius: 20,
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: Colors.purple.shade100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Stack(
              //   clipBehavior: Clip.none, alignment: Alignment.center,
              //   children: <Widget>[
              //     Container(
              //       width: 250,
              //       height: 100,
              //       padding: EdgeInsets.all(55),
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.purple,
              //             spreadRadius: 10,
              //             blurRadius: 100,
              //             // offset: Offset(0,0),
              //           ),
              //         ],
              //         borderRadius: BorderRadius.circular(25),
              //         gradient: LinearGradient(
              //           colors: [
              //             Colors.purple.shade900,
              //             Colors.purple.shade400,
              //           ],
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       top: 80,
              //       child: Container(
              //         width: 350,
              //         height: 100,
              //         decoration: BoxDecoration(
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.purple,
              //               spreadRadius: 10,
              //               blurRadius: 100,
              //               // offset: Offset(0,0),
              //             ),
              //           ],
              //           borderRadius: BorderRadius.circular(25),
              //           gradient: LinearGradient(
              //             colors: [
              //               Colors.purple.shade100,
              //               Colors.purple.shade200,
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
