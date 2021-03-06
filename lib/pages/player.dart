import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:smash_media/models/music_list.dart';

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
// In case if the author of the song is not available, nothing is displayed,
// otherwise, the author name is displayed,
// as in this case you can see the author name of the song is not present
// But if we have the author name, then it is displayed
class _PlayerState extends State<Player> {
  bool like = false, dislike = false;
  bool repeatPlaylist = false, repeatSong = false;

  Icon repeatIcon = repeatDisabledIcon;
  repeatState currentRepeatState = repeatState.disabled;

  Color shuffleColor = Colors.black54;
  shuffleState currentShuffleState = shuffleState.disabled;
  @override
  Widget build(BuildContext context) {
    bool isPlaying = Provider.of<DataListClass>(context).data.isPlaying;
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
                // TODO: Connect to DataListClass
                setState(() {
                  like = !like;
                  if (like) {
                    if (dislike) {
                      dislike = false;
                    }
                  }
                });
              },
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Center(
                  child: Marquee(
                    child: Text(
                      Provider.of<DataListClass>(context).data.currentTitle ??
                          "No Music",
                      style: kTextStyle,
                    ),
                    directionMarguee: DirectionMarguee.oneDirection,
                    pauseDuration: Duration(milliseconds: 1000),
                  ),
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
            // TODO: Only load the text widget if the song has an author, remove otherwise
            child: Text(
              // Show nothing if the author is not available
              Provider.of<DataListClass>(context).data.currentSinger ==
                      "<unknown>"
                  ? ""
                  : Provider.of<DataListClass>(context).data.currentSinger,
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
            onChanged:
                Provider.of<DataListClass>(context, listen: false).seekTo,
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
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_previous_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {},
              ),
              Container(
                child: IconButton(
                  onPressed: () {
                    if (isPlaying) {
                      Provider.of<DataListClass>(context, listen: false)
                          .pauseMusic();
                    } else {
                      Provider.of<DataListClass>(context, listen: false)
                          .resumeMusic();
                    }
                  },
                  // TODO: Change Icon through the state of the music
                  icon: Icon(
                      isPlaying
                          ? Icons.pause_outlined
                          : Icons.play_arrow_outlined,
                      size: 50),
                ),
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
              ),
            ],
          ),
        ],
      )),
    );
  }
}
