import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'music_list.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

List<SongInfo> songsList;
class SongsPage extends StatefulWidget {
  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {

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
    }
    else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if(result == 1) {
        setState(() {
          isPlaying = true;
        });
        Provider.of<DataListClass>(context, listen: false).updateData(
          currentBtnIcon: Icons.pause,
          currentUrl: Provider.of<DataListClass>(context, listen: false).data.currentUrl,
          currentSinger: Provider.of<DataListClass>(context, listen: false).data.currentSinger,
          currentTitle: Provider.of<DataListClass>(context, listen: false).data.currentTitle,
          currentImage: Provider.of<DataListClass>(context, listen: false).data.currentImage,
          currentIsPlaying: isPlaying,
          duration: Duration(seconds: 0),
          position: Duration(seconds: 0)
        );
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      Provider.of<DataListClass>(context, listen: false).updateData(
        currentBtnIcon: Provider.of<DataListClass>(context, listen: false).data.btnIcon,
        currentUrl: Provider.of<DataListClass>(context, listen: false).data.currentUrl,
        currentSinger: Provider.of<DataListClass>(context, listen: false).data.currentSinger,
        currentTitle: Provider.of<DataListClass>(context, listen: false).data.currentTitle,
        currentImage: Provider.of<DataListClass>(context, listen: false).data.currentImage,
        currentIsPlaying: Provider.of<DataListClass>(context, listen: false).data.isPlaying,
        duration: event,
        position: Provider.of<DataListClass>(context, listen: false).data.position,
      );
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      Provider.of<DataListClass>(context, listen: false).updateData(
        currentBtnIcon: Provider.of<DataListClass>(context, listen: false).data.btnIcon,
        currentUrl: Provider.of<DataListClass>(context, listen: false).data.currentUrl,
        currentSinger: Provider.of<DataListClass>(context, listen: false).data.currentSinger,
        currentTitle: Provider.of<DataListClass>(context, listen: false).data.currentTitle,
        currentImage: Provider.of<DataListClass>(context, listen: false).data.currentImage,
        currentIsPlaying: Provider.of<DataListClass>(context, listen: false).data.isPlaying,
        duration: Provider.of<DataListClass>(context, listen: false).data.duration,
        position: event,
      );
    });
  }
  // Collects information about all the music in the file storage
  final Future<List<SongInfo>> _songs = FlutterAudioQuery().getSongs();
  @override
  Widget build(BuildContext context) {

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
                  SizedBox(
                    height: 150,
                    // width: 150,
                    child: ListView.builder(
                        itemCount: musicList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => musicCard(
                          cover: musicList[index]['cover'],
                        ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    // FutureBuilder waits for the songs to be collected and then refreshes the Widget
                    child: FutureBuilder<List<SongInfo>>(
                      future: _songs,
                      builder: (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot) {

                        if (snapshot.hasData) {
                          songsList = snapshot.data;
                        }
                        else {
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
                              String currentImage = songsList[index].albumArtwork;
                              String currentSinger = songsList[index].artist;
                              IconData currentBtnIcon = Icons.pause;
                              // bool currentIsPlaying = false;
                                  {print(currentUrl);}
                              // audio.play(currentUrl);
                                  {print("playMusic Start");}
                              playMusic(currentUrl);
                              {print("playMusic End");}
                              Provider.of<DataListClass>(context, listen: false).updateData(
                                  currentTitle: currentTitle,
                                  currentSinger: currentSinger,
                                  currentUrl: currentUrl,
                                  currentImage: currentImage,
                                  currentBtnIcon: currentBtnIcon,
                                  currentIsPlaying: isPlaying,
                                  duration: Duration(seconds: 0),
                                  position: Duration(seconds: 0)
                              );
                            },
                            title: songsList[index].title,
                            artist: songsList[index].artist,
                            albumArtwork: songsList[index].albumArtwork,
                          ),
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget customListTile({String title, String artist, String albumArtwork, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      // margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: albumArtwork != null ? FileImage(File(albumArtwork)) : AssetImage('assets/no_cover.png'),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    artist,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
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
              image: NetworkImage(cover),
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


