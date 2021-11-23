import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

class Data {
  String currentTitle;
  String currentUrl;
  String currentImage;
  String currentSinger;
  IconData btnIcon = Icons.play_arrow;
  bool isPlaying = false;
  Duration duration = new Duration();
  Duration position = new Duration();
  FlutterAudioQuery audioQuery = new FlutterAudioQuery();
  List<SongInfo> songs;

  Data({
    this.currentImage,
    this.currentUrl,
    this.currentSinger,
    this.currentTitle,
    this.btnIcon,
    this.isPlaying,
    this.duration,
    this.position,
    this.audioQuery,
  });
}

class DataListClass extends ChangeNotifier {
  Data data = Data(
      currentTitle: "No Music",
      currentImage: null,
      currentUrl: null,
      currentSinger: "Harry Osborn",
      btnIcon: Icons.play_arrow,
      isPlaying: false,
      duration: Duration(seconds: 0),
      position: Duration(days: 0),
      audioQuery: new FlutterAudioQuery());

  void updateData(
      {String currentTitle,
      String currentUrl,
      String currentImage,
      String currentSinger,
      IconData currentBtnIcon,
      bool currentIsPlaying,
      Duration duration,
      Duration position,
      FlutterAudioQuery flutterAudioQuery}) {
    data.currentImage = currentImage;
    data.currentTitle = currentTitle;
    data.currentUrl = currentUrl;
    data.currentSinger = currentSinger;
    data.isPlaying = currentIsPlaying;
    data.duration = duration;
    data.position = position;
    data.audioQuery = flutterAudioQuery;
    // data = Data(
    //   currentTitle: currentTitle,
    //   currentImage: currentImage,
    //   currentUrl: currentUrl,
    //   currentSinger: currentSinger,
    //   btnIcon: currentBtnIcon,
    //   isPlaying: currentIsPlaying,
    //   duration: duration,
    //   position: position,
    //   audioQuery: new FlutterAudioQuery()
    // );
    notifyListeners();
  }

  void updateAudioQuery() {
    data.audioQuery = new FlutterAudioQuery();
    notifyListeners();
  }

  Future<void> updateSongs() async {
    print("Gettings Songs");
    data.songs = await data.audioQuery.getSongs();
    print("Gettings Songs Done");
    return;
  }
}
