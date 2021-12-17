import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:smash_media/pages/songs_page.dart';

AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

Duration duration = new Duration();
Duration position = new Duration();

class Data {
  String currentTitle;
  String currentUrl;
  String currentImage;
  String currentSinger;
  bool isPlaying = false;
  Duration duration = new Duration();
  Duration position = new Duration();
  FlutterAudioQuery audioQuery = new FlutterAudioQuery();
  List<SongInfo> songs;
  AudioPlayer audioPlayer;

  Data({
    this.currentImage,
    this.currentUrl,
    this.currentSinger,
    this.currentTitle,
    this.isPlaying,
    this.duration,
    this.position,
    this.audioQuery,
    this.audioPlayer,
  });

  // {
  // songs = this.audioQuery.getSongs();
  // }

  // get currentIndex =>
  // songs.indexOf(songsList.firstWhere((song) => song.title == currentTitle));
}

class DataListClass extends ChangeNotifier {
  Data data = Data(
    currentTitle: "No Music",
    currentImage: null,
    currentUrl: null,
    currentSinger: "Harry Osborn",
    isPlaying: false,
    duration: Duration(seconds: 0),
    position: Duration(days: 0),
    audioQuery: new FlutterAudioQuery(),
    audioPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER),
  );

  void updateData(
      {String currentTitle,
      String currentUrl,
      String currentImage,
      String currentSinger,
      bool currentIsPlaying,
      Duration duration,
      Duration position,
      FlutterAudioQuery flutterAudioQuery,
      currentIndex}) {
    data.currentImage = currentImage;
    data.currentTitle = currentTitle;
    data.currentUrl = currentUrl;
    data.currentSinger = currentSinger;
    data.isPlaying = currentIsPlaying;
    data.duration = duration;
    data.position = position;
    notifyListeners();
  }

  Future<void> getSongs() async {
    data.songs = await data.audioQuery.getSongs();
    notifyListeners();
  }

  Future<void> playMusic(SongInfo song) async {
    stopMusic();
    if (await data.audioPlayer.play(song.filePath) == 1) {
      data.isPlaying = true;
      data.currentUrl = song.filePath;
      data.currentTitle = song.title;
      data.currentSinger = song.artist;
      data.audioPlayer.onDurationChanged.listen((Duration d) {
        data.duration = d;
        notifyListeners();
      });
      data.audioPlayer.onAudioPositionChanged.listen((Duration p) {
        data.position = p;
        notifyListeners();
      });
      notifyListeners();
    }
    // data.isPlaying = true;
    // notifyListeners();
  }

  Future<void> seekTo(double value) async {
    await data.audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  void stopMusic() {
    data.audioPlayer.stop();
    data.isPlaying = false;
  }

  void pauseMusic() {
    data.audioPlayer.pause();
    data.isPlaying = false;
    notifyListeners();
  }

  void resumeMusic() {
    data.audioPlayer.resume();
    data.isPlaying = true;
    notifyListeners();
  }

  void updateAudioQuery() {
    data.audioQuery = new FlutterAudioQuery();
    notifyListeners();
  }

  void seek(double value) {
    data.audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  void setDuration(event) {
    data.duration = event;
    notifyListeners();
  }

  void setPosition(event) {
    data.position = event;
    notifyListeners();
  }

  Future<void> updateSongs() async {
    data.songs = await data.audioQuery.getSongs();
    return;
  }
}
