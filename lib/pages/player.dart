import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_media/models/music_list.dart';

import '../constants.dart';

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
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
              child: Container(
            height: 225,
            width: 225,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/no_cover.png'),
            )),
          )),
          SizedBox(
            height: 80,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                icon: Icon(
                  Icons.thumb_up_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
                padding: EdgeInsets.only(left: 10)),
            Center(
              child: Text(
                "Music Name",
                style: kTextStyle,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.thumb_down_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
                padding: EdgeInsets.only(left: 10)),
          ]),
          Center(
            child: Text(
              "Author Name",
              style: const TextStyle(
                  fontFamily: 'Varela', fontSize: 22, color: Colors.black45),
            ),
          ),
          Slider.adaptive(
            activeColor: Colors.white,
            inactiveColor: Colors.black87,
            value: Provider.of<DataListClass>(context)
                .data
                .position
                .inSeconds
                .toDouble(),
            min: 0.0,
            max: Provider.of<DataListClass>(context)
                .data
                .duration
                .inSeconds
                .toDouble(),
            onChanged: (value) {
              {
                // Provider.of<DataListClass>(context).updateData()
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.skip_previous_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
                padding: EdgeInsets.only(left: 10),
              ),

              // IconButton(
              //   // padding: EdgeInsets.only(left: 60),
              //   onPressed: () {},
              //   icon: Image.asset(
              //     'assets/images/prev.png',
              //     height: 100,
              //     width: 100,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     print("Tapped!");
              //   },
              //   child: Container(
              //     height: 75,
              //     width: 75,
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //       image: AssetImage('assets/images/play.png'),
              //     )),
              //   ),
              // ),
              // TODO: Center the Play button inside
              // If we use EdgeInsets.fromLTRB padding then the Play button is in the middle, but the pause button is shifted to right
              // If we use EdgeInsets.all padding then the Play button is to a little left, but the pause button is in middle
              Container(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/play.png',
                  ),
                ),
                height: 100,
                width: 100,
                // margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.fromLTRB(25, 20, 20, 20),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent, shape: BoxShape.circle),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next_outlined,
                  color: Colors.black,
                  size: 50,
                ),
                onPressed: () {},
                padding: EdgeInsets.only(left: 10),
              ),
              // IconButton(
              //   // padding: EdgeInsets.only(right: 60),
              //   onPressed: () {},
              //   icon: Image.asset(
              //     'assets/images/next.png',
              //     height: 100,
              //     width: 100,
              //   ),
              // ),
            ],
          ),
          // Image.asset('assets/images/previous.png'),
        ],
      )),
    );
  }
}
