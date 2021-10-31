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
                  Positioned(
                    top: 15,
                    left: 10,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 35,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          print('Search');
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Positioned(
                    top: 90,
                    left: 20,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Browse",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                        ],
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
