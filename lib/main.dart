import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_media/constants.dart';
import 'package:smash_media/models/music_list.dart';
import 'package:smash_media/pages/player.dart';
import 'package:smash_media/pages/songs_page.dart';
import './pages/songs_page.dart';

void main() {
  runApp(MyHomePage());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Premium Music",
              style: kSplashTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataListClass>(
      create: (context) => DataListClass(),
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  SearchBar _searchBar;
  TabController _tabController;
  FlutterAudioQuery _audioQuery;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.search, size: 35, color: Colors.black45),
          onPressed: () {
            _searchBar.beginSearch(context);
          },
        ),
        actions: [
          // Old Refresh Indicator, removed since Pull to Refresh
          // IconButton(onPressed: () => {}, icon: Icon(Icons.refresh_rounded,  size: 35, color: Colors.black45)),
          IconButton(
            icon: Icon(Icons.queue_music, size: 35, color: Colors.black45),
            onPressed: () {
              // TODO: Implement Music Queue
              // print('Music Queue');
            },
          )
        ]);
  }

  // TODO: Display the queries to screen and connected it to the audio player
  void searchQuery(String query) async {
    List<SongInfo> results = await _audioQuery.searchSongs(query: query);
    // print(results);
  }

  @override
  void initState() {
    super.initState();
    askStoragePermission();
    _tabController = TabController(length: 1, vsync: this);
    _audioQuery = FlutterAudioQuery();
    _searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: searchQuery,
        buildDefaultAppBar: buildAppBar);
  }

  void askStoragePermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool storageAlreadyDeniedOnce =
        prefs.getBool('storageAlreadyDeniedOnce') ?? false;
    print("Storage Permission: storageAlreadyDeniedOnce: " +
        storageAlreadyDeniedOnce.toString());
    if (storageAlreadyDeniedOnce) {
      return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // TODO: Add Styling
                  const Text(
                      'Go to settings and enable File Storage Permissions'),
                  ElevatedButton(
                      onPressed: openAppSettings, child: const Text('Okay')),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"))
                ],
              ),
            ),
          );
        },
      );
    } else if (await Permission.storage.status.isDenied) {
      if (!(await Permission.storage.request().isGranted)) {
        await prefs.setBool('storageAlreadyDeniedOnce', false);
      } else if (await Permission.storage.isGranted) {
        // print("Acquired");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _searchBar.build(context),
        // Added Pull To Refresh
        body: RefreshIndicator(
          onRefresh: () {
            // Refreshes the songs list in case the user has added some new songs to device storage
            Provider.of<DataListClass>(context, listen: false)
                .updateAudioQuery();

            // print("Songs");
            // print(
            // Provider.of<DataListClass>(context, listen: false).data.songs);
            return Provider.of<DataListClass>(context, listen: false)
                .updateSongs();
          },
          child: ListView(
            padding: EdgeInsets.only(left: 20.0),
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                'Browse',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 15,
              ),

              /*TODO: TabBar */
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Color(0xFFFF9544),
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45),
                unselectedLabelColor: Color(0xFFCDCDCD),
                tabs: [
                  CreateTab(tabName: 'Downloads'),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SongsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 120,
          child: Container(
              width: MediaQuery.of(context).size.width, child: BottomPlayer()),
        ));
  }
}

class BottomPlayer extends StatelessWidget {
  // void seek(double value) {
  //   audioPlayer.seek(Duration(seconds: value.toInt()));
  // }

  @override
  Widget build(BuildContext context) {
    DataListClass songData = Provider.of<DataListClass>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Player()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x55212121),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Slider.adaptive(
              activeColor: Color(0xFFFF9544),
              inactiveColor: Color(0xFFFFE6D9),
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
              // (value) {
              //   {
              //     // TODO: Change to seekTo
              //     Provider.of<DataListClass>(context, listen: false).seekTo(value);
              //   }
              // }
              // ,
            ),
            // Error Image Soource
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/images/no_cover.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Marquee(
                            child: Text(
                              Provider.of<DataListClass>(context)
                                  .data
                                  .currentTitle,
                              style: TextStyle(
                                // fontSize: ,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textDirection: TextDirection.rtl,
                            animationDuration: Duration(seconds: 1),
                            backDuration: Duration(milliseconds: 5000),
                            pauseDuration: Duration(milliseconds: 2000),
                            directionMarguee: DirectionMarguee.TwoDirection,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Marquee(
                          child: Text(
                            // TODO: Only load the text widget if the song has an author, remove otherwise
                            Provider.of<DataListClass>(context)
                                        .data
                                        .currentSinger ==
                                    "<unknown>"
                                ? ""
                                : Provider.of<DataListClass>(context)
                                    .data
                                    .currentSinger,
                            style: TextStyle(
                              color: Colors.grey,
                              // fontSize: 14,
                            ),
                          ),
                          textDirection: TextDirection.ltr,
                          animationDuration: Duration(seconds: 1),
                          backDuration: Duration(milliseconds: 5000),
                          pauseDuration: Duration(milliseconds: 2000),
                          directionMarguee: DirectionMarguee.TwoDirection,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(songData.data.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      // print(songData.data.isPlaying);
                      if (songData.data.isPlaying) {
                        // print("Music Playing");
                        songData.pauseMusic();

                        // audioPlayer.pause();

                        // Provider.of<DataListClass>(context, listen: false)
                        //     .updateData(
                        //   currentUrl:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentUrl,
                        //   currentSinger:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentSinger,
                        //   currentTitle:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentTitle,
                        //   currentImage:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentImage,
                        //   currentIsPlaying: false,
                        //   duration:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .duration,
                        //   position:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .position,
                        // );
                      } else {
                        songData.resumeMusic();
                        // print("Music Paused");
                        // audioPlayer.resume();
                        // Provider.of<DataListClass>(context, listen: false)
                        //     .updateData(
                        //   currentBtnIcon: Icons.pause,
                        //   currentUrl:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentUrl,
                        //   currentSinger:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentSinger,
                        //   currentTitle:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentTitle,
                        //   currentImage:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .currentImage,
                        //   currentIsPlaying: true,
                        //   duration:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .duration,
                        //   position:
                        //       Provider.of<DataListClass>(context, listen: false)
                        //           .data
                        //           .position,
                        // );
                      }
                    },
                    iconSize: 42,
                    color: Color(0xFFFF9544),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Tabs Section
class CreateTab extends StatelessWidget {
  CreateTab({
    this.tabName,
  });

  final String tabName;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tabName,
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tabName', tabName));
  }
}
