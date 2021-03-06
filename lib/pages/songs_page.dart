import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:marquee_widget/marquee_widget.dart';
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
            // height: MediaQuery.of(context).size.height - 50,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 250,
                      // FutureBuilder waits for the songs to be collected and then refreshes the Widget
                      child: FutureBuilder<List<SongInfo>>(
                        future: _songs,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<SongInfo>> snapshot) {
                          if (snapshot.hasData) {
                            songsList = snapshot.data;
                            // print(snapshot.data);
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
                              onTap: () async {
                                await Provider.of<DataListClass>(context,
                                        listen: false)
                                    .playMusic(songsList[index]);
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

// All the music cards are generated here, using a list builder
// which makes sure that even if there are 1000s of songs, the app doesn't crash
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
                  Marquee(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                    animationDuration: Duration(seconds: 1),
                    backDuration: Duration(milliseconds: 5000),
                    pauseDuration: Duration(milliseconds: 2000),
                    directionMarguee: DirectionMarguee.oneDirection,
                  ),
                  Marquee(
                    child: Text(
                      artist,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                    animationDuration: Duration(seconds: 1),
                    backDuration: Duration(milliseconds: 5000),
                    pauseDuration: Duration(milliseconds: 2000),
                    directionMarguee: DirectionMarguee.TwoDirection,
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
        // TODO: What is this?
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
