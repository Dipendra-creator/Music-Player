import 'dart:io';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

import '../models/music_list.dart';

List<SongInfo> songsList;

class SongsPage extends StatefulWidget {
  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  _SongsPageState();

  // Collects information about all the music in the file storage
  Future<List<SongInfo>> _songs;

  @override
  void initState() {
    super.initState();
  }

  bool isPlaying = false;
  String currentSong = "";

  void playMusic(String url) async {
    if (isPlaying && currentSong != null) {
      audioPlayer.stop();
      int result = await audioPlayer.play(url);
      print(result);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
        Provider.of<DataListClass>(context, listen: false).updateData(
            currentBtnIcon: Icons.pause,
            currentUrl: Provider.of<DataListClass>(context, listen: false)
                .data
                .currentUrl,
            currentSinger: Provider.of<DataListClass>(context, listen: false)
                .data
                .currentSinger,
            currentTitle: Provider.of<DataListClass>(context, listen: false)
                .data
                .currentTitle,
            currentImage: Provider.of<DataListClass>(context, listen: false)
                .data
                .currentImage,
            currentIsPlaying: isPlaying,
            duration: Duration(seconds: 0),
            position: Duration(seconds: 0));
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      Provider.of<DataListClass>(context, listen: false).updateData(
        currentBtnIcon:
            Provider.of<DataListClass>(context, listen: false).data.btnIcon,
        currentUrl:
            Provider.of<DataListClass>(context, listen: false).data.currentUrl,
        currentSinger: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentSinger,
        currentTitle: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentTitle,
        currentImage: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentImage,
        currentIsPlaying:
            Provider.of<DataListClass>(context, listen: false).data.isPlaying,
        duration: event,
        position:
            Provider.of<DataListClass>(context, listen: false).data.position,
      );
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      Provider.of<DataListClass>(context, listen: false).updateData(
        currentBtnIcon:
            Provider.of<DataListClass>(context, listen: false).data.btnIcon,
        currentUrl:
            Provider.of<DataListClass>(context, listen: false).data.currentUrl,
        currentSinger: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentSinger,
        currentTitle: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentTitle,
        currentImage: Provider.of<DataListClass>(context, listen: false)
            .data
            .currentImage,
        currentIsPlaying:
            Provider.of<DataListClass>(context, listen: false).data.isPlaying,
        duration:
            Provider.of<DataListClass>(context, listen: false).data.duration,
        position: event,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _songs = Provider.of<DataListClass>(context, listen: false)
        .data
        .audioQuery
        .getSongs();
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 50,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Removed Column Songs, since they were the same songs
                  // shown on a different axis
                  // SizedBox(
                  //   height: 150,
                  //   // width: 150,
                  //   child: ListView.builder(
                  //     itemCount: ,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) => musicCard(
                  //       cover: musicList[index]['cover'],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      // FutureBuilder waits for the songs to be collected and then refreshes the Widget
                      child: FutureBuilder<List<SongInfo>>(
                        future: _songs,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<SongInfo>> snapshot) {
                          if (snapshot.hasData) {
                            songsList = snapshot.data;
                            print(snapshot.data);
                          } else {
                            // Show a Progress Indicator until the data has been collected
                            return SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            );
                          }
                          return ListView.builder(
                            itemCount: songsList.length,
                            itemBuilder: (context, index) => customListTile(
                              onTap: () {
                                String currentTitle = songsList[index].title;
                                String currentUrl = songsList[index].filePath;
                                String currentImage =
                                    songsList[index].albumArtwork;
                                String currentSinger = songsList[index].artist;
                                IconData currentBtnIcon = Icons.pause;
                                // bool currentIsPlaying = false;
                                {
                                  print(currentUrl);
                                }
                                // audio.play(currentUrl);
                                playMusic(currentUrl);
                                Provider.of<DataListClass>(context,
                                        listen: false)
                                    .updateData(
                                        currentTitle: currentTitle,
                                        currentSinger: currentSinger,
                                        currentUrl: currentUrl,
                                        currentImage: currentImage,
                                        currentBtnIcon: currentBtnIcon,
                                        currentIsPlaying: isPlaying,
                                        duration: Duration(seconds: 0),
                                        position: Duration(seconds: 0));
                              },
                              title: songsList[index].title,
                              artist: songsList[index].artist,
                              albumArtwork: songsList[index].albumArtwork,
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget customListTile(
    {String title, String artist, String albumArtwork, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      // margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: albumArtwork != null
                    ? FileImage(File(albumArtwork))
                    : AssetImage('assets/images/no_cover.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Marquee(
                  //   text: title,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  //   scrollAxis: Axis.horizontal,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   blankSpace: 20.0,
                  //   velocity: 100.0,
                  //   pauseAfterRound: Duration(seconds: 1),
                  //   startPadding: 10.0,
                  //   accelerationDuration: Duration(seconds: 1),
                  //   accelerationCurve: Curves.linear,
                  //   decelerationDuration: Duration(milliseconds: 500),
                  //   decelerationCurve: Curves.easeOut,
                  // ),
                  Marquee(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // scrollAxis: Axis.horizontal,
                    textDirection : TextDirection.rtl,
                    animationDuration: Duration(seconds: 1),
                    backDuration: Duration(milliseconds: 5000),
                    pauseDuration: Duration(milliseconds: 10),
                    directionMarguee: DirectionMarguee.oneDirection,
                  ),
                  // Removed SizedBox to remove Overflow
                  // SizedBox(height: 5.0),
                  Marquee(
                    child: Text(
                      artist,
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                    // scrollAxis: Axis.horizontal,
                    textDirection : TextDirection.rtl,
                    animationDuration: Duration(seconds: 1),
                    backDuration: Duration(milliseconds: 5000),
                    pauseDuration: Duration(milliseconds: 0),
                    directionMarguee: DirectionMarguee.oneDirection,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget musicCard({String title, String singer, String cover, onTap}) {
  return Container(
    height: 100,
    width: 120,
    // color: Colors.red,
    child: Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 5),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: cover != null
                  ? FileImage(File(cover))
                  : AssetImage('assets/images/no_cover.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFF9544).withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
            color: Color(0xFFFF9544),
          ),
        ),
      ),
    ),
  );
}
