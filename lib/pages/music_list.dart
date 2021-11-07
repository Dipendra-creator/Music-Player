import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List musicList = [
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://i1.sndcdn.com/artworks-kI4aED2cdGKItyrc-1GpyCw-t500x500.jpg",
    'url': "https://drive.google.com/uc?id=1dpR_SGNKq1el4LyI6I6Etd8I7dm6VJrt&export=download",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXMQSnexRlzw4qfituPhcrXX-7zb01nnZaaw&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQt5mTgJQm4DfDlezwlh_bc9zcRb0duH1vycL5nl-7BkvRwVNbUOYhKrh-zI8UxQqUJHY&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYyDr6krUsT_TH9Xa_XvWgLyiCNdwzpV4meg&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYMYtQBIoylI8olEY9VqQ-xYuHcsHHuV5zBkMWnzaR2dGB2YQ7dvLaLsokl7Qq_UB4kvY&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://c8.alamy.com/comp/2F8BJB5/music-speakers-background-album-cover-poster-2F8BJB5.jpg",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp3nHA0G08-OMcphcYSu4Aa9FjZvkf2331lQ&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://i1.sndcdn.com/artworks-kI4aED2cdGKItyrc-1GpyCw-t500x500.jpg",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYyDr6krUsT_TH9Xa_XvWgLyiCNdwzpV4meg&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYMYtQBIoylI8olEY9VqQ-xYuHcsHHuV5zBkMWnzaR2dGB2YQ7dvLaLsokl7Qq_UB4kvY&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://c8.alamy.com/comp/2F8BJB5/music-speakers-background-album-cover-poster-2F8BJB5.jpg",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp3nHA0G08-OMcphcYSu4Aa9FjZvkf2331lQ&usqp=CAU",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'title': "Tech House vibes",
    'singer': "Alejandro Magaña",
    'cover': "https://i1.sndcdn.com/artworks-kI4aED2cdGKItyrc-1GpyCw-t500x500.jpg",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  }
];

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

  Data({
    this.currentImage,
    this.currentUrl,
    this.currentSinger,
    this.currentTitle,
    this.btnIcon,
    this.isPlaying,
    this.duration,
    this.position,
  });
}

class DataListClass extends ChangeNotifier{
  Data data = Data(
    currentTitle: musicList[0]['title'],
    currentImage: musicList[0]['cover'],
    currentUrl: musicList[0]['url'],
    currentSinger: musicList[0]['singer'],
    btnIcon: Icons.play_arrow,
    isPlaying: false,
    duration: Duration(seconds: 0),
    position: Duration(days: 0)
    );

  void updateData(
      {
        String currentTitle,
        String currentUrl,
        String currentImage,
        String currentSinger,
        IconData currentBtnIcon,
        bool currentIsPlaying,
        Duration duration,
        Duration position
      }) {
    data = Data(
      currentTitle: currentTitle,
      currentImage: currentImage,
      currentUrl: currentUrl,
      currentSinger: currentSinger,
      btnIcon: currentBtnIcon,
      isPlaying: currentIsPlaying,
      duration: duration,
      position: position
    );
    notifyListeners();
  }
}


