import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_media/models/music_list.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../constants.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

Icon repeatDisabledIcon = Icon(
  Icons.repeat_rounded,
  color: Colors.black54,
  size: 35,
);
Icon repeatPlaylistIcon = Icon(
  Icons.repeat_rounded,
  color: Colors.black,
  size: 35,
);
Icon repeatSongIcon = Icon(
  Icons.repeat_one_outlined,
  color: Colors.black,
  size: 35,
);
enum repeatState {
  disabled,
  playlist,
  song,
}
enum shuffleState {
  disabled,
  enabled,
}

class _PlayerState extends State<Player> {
  bool like = false, dislike = false;
  bool repeatPlaylist = false, repeatSong = false;

  Icon repeatIcon = repeatDisabledIcon;
  repeatState currentRepeatState = repeatState.disabled;

  Color shuffleColor = Colors.black54;
  shuffleState currentShuffleState = shuffleState.disabled;
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
                like ? Icons.thumb_up : Icons.thumb_up_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  like = !like;
                  if (like) {
                    if (dislike) {
                      dislike = false;
                    }
                  }
                });
              },
              // padding: EdgeInsets.only(left: 10),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Marquee(
                  child: Text(
                    Provider.of<DataListClass>(context).data.currentTitle ??
                        "No Music",
                    // "Music Name",
                    style: kTextStyle,
                  ),
                  textDirection : TextDirection.rtl,
                  animationDuration: Duration(seconds: 1),
                  backDuration: Duration(milliseconds: 5000),
                  pauseDuration: Duration(milliseconds: 2000),
                  directionMarguee: DirectionMarguee.TwoDirection,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                dislike ? Icons.thumb_down : Icons.thumb_down_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  dislike = !dislike;
                  if (dislike) {
                    if (like) {
                      like = false;
                    }
                  }
                });
              },
              // padding: EdgeInsets.only(left: 10),
            ),
          ]),
          Center(
            child: Text(
              Provider.of<DataListClass>(context).data.currentSinger,
              // "Author Name",
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
                  Icons.shuffle_rounded,
                  color: shuffleColor,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    if (currentShuffleState == shuffleState.disabled) {
                      currentShuffleState = shuffleState.enabled;
                      shuffleColor = Colors.black;
                    } else {
                      currentShuffleState = shuffleState.disabled;
                      shuffleColor = Colors.black54;
                    }
                  });
                },
                // padding: EdgeInsets.only(left: 10),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_previous_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
                // padding: EdgeInsets.only(left: 10),
              ),
              Container(
                child: IconButton(
                    onPressed: () {},
                    // Icons.pause_outline
                    // TODO: Change Icon through the state of the music
                    icon: Icon(Icons.play_arrow_outlined, size: 50)),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent, shape: BoxShape.circle),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
                // padding: EdgeInsets.only(left: 10),
              ),
              IconButton(
                icon: repeatIcon,
                onPressed: () {
                  if (currentRepeatState == repeatState.disabled) {
                    setState(() {
                      repeatIcon = repeatPlaylistIcon;
                      currentRepeatState = repeatState.playlist;
                    });
                  } else if (currentRepeatState == repeatState.playlist) {
                    setState(() {
                      repeatIcon = repeatSongIcon;
                      currentRepeatState = repeatState.song;
                    });
                  } else if (currentRepeatState == repeatState.song) {
                    setState(() {
                      repeatIcon = repeatDisabledIcon;
                      currentRepeatState = repeatState.disabled;
                    });
                  }
                },
                // padding: EdgeInsets.only(left: 10),
              ),
              // IconButton(
              //   icon: Icon(
              //     color: Colors.black,
              //     size: 35,
              //   ),
              //   onPressed: () {},
              //   padding: EdgeInsets.only(left: 10),
              // ),
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
