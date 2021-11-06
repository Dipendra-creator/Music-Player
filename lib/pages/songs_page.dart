import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'music_list.dart';

class SongsPage extends StatefulWidget {
  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {

  // Audio Player
  Duration duration = new Duration();
  Duration position = new Duration();

  bool isPlaying = false;
  String currentSong = "";


  void playMusic(String url) async {
    if (isPlaying && currentSong != null) {
      print("isPlaying is True \n currentSong is currentUrl");
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
      print("isPlaying is False");
      int result = await audioPlayer.play(url);
      if(result == 1) {
        setState(() {
          isPlaying = true;
        });
        // {print("isPlaying is not true condition mai $isPlaying");}
        Provider.of<DataListClass>(context, listen: false).updateData(
          currentIsPlaying: isPlaying
        );
        // {print("isPlaying is not true condition mai ${Provider.of<DataListClass>(context, listen: false).data.isPlaying}");}
      }
    }
  }


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
            // padding: EdgeInsets.only(right: 15),
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
                    child: ListView.builder(
                      itemCount: musicList.length,
                      itemBuilder: (context, index) => customListTile(
                        onTap: () {
                          String currentTitle = musicList[index]['title'];
                          String currentUrl = musicList[index]['url'];
                          String currentImage = musicList[index]['cover'];
                          String currentSinger = musicList[index]['singer'];
                          IconData currentBtnIcon = Icons.play_arrow;
                          bool currentIsPlaying = false;
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
                            currentIsPlaying: isPlaying
                          );
                        },
                        title: musicList[index]['title'],
                        singer: musicList[index]['singer'],
                        cover: musicList[index]['cover'],
                      ),
                    ),
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


Widget customListTile({String title, String singer, String cover, onTap}) {
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
                  image: NetworkImage(cover),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Center(
            child: Column(
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
                  singer,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
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
    child: _buildCard(cover),
  );
}

Widget _buildCard(String cover) {
  return Padding(
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
  );
}
