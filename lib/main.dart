import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_media/models/music_list.dart';
import 'package:smash_media/pages/player.dart';
import 'package:smash_media/pages/songs_page.dart';

import './pages/songs_page.dart';

void main() {
  runApp(MyHomePage());
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
        home: Home(),
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
              print('Music Queue');
            },
          )
        ]);
  }

  // TODO: Display the queries to screen and connected it to the audio player
  void searchQuery(String query) async {
    List<SongInfo> results = await _audioQuery.searchSongs(query: query);
    print(results);
  }

  @override
  void initState() {
    super.initState();
    askStoragePermission();
    _tabController = TabController(length: 4, vsync: this);
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
        print("Acquired");
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

            print("Songs");
            print(
                Provider.of<DataListClass>(context, listen: false).data.songs);
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
                  CreateTab(tabName: 'Songs'),
                  CreateTab(tabName: 'Playlist'),
                  CreateTab(tabName: 'Podcast'),
                  CreateTab(tabName: 'Downloaded'),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SongsPage(),
                    SongsPage(),
                    SongsPage(),
                    SongsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 120,
          child: BottomPlayer(),
        ));
  }
}

class BottomPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              onChanged: (value) {
                {
                  // Provider.of<DataListClass>(context).updateData()
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://w7.pngwing.com/pngs/710/955/png-transparent-vinyl-record-artwork-phonograph-record-compact-disc-lp-record-disc-jockey-symbol-miscellaneous-classical-music-sound.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<DataListClass>(context).data.currentTitle,
                        style: TextStyle(
                          // fontSize: ,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        Provider.of<DataListClass>(context).data.currentSinger,
                        style: TextStyle(
                          color: Colors.grey,
                          // fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                        Provider.of<DataListClass>(context, listen: false)
                            .data
                            .btnIcon),
                    onPressed: () {
                      {
                        print(Provider.of<DataListClass>(context, listen: false)
                            .data
                            .isPlaying);
                      }
                      if (Provider.of<DataListClass>(context, listen: false)
                          .data
                          .isPlaying) {
                        audioPlayer.pause();
                        Provider.of<DataListClass>(context, listen: false)
                            .updateData(
                          currentBtnIcon: Icons.play_arrow,
                          currentUrl:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentUrl,
                          currentSinger:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentSinger,
                          currentTitle:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentTitle,
                          currentImage:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentImage,
                          currentIsPlaying: false,
                          duration:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .duration,
                          position:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .position,
                        );
                      } else {
                        audioPlayer.resume();
                        Provider.of<DataListClass>(context, listen: false)
                            .updateData(
                          currentBtnIcon: Icons.pause,
                          currentUrl:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentUrl,
                          currentSinger:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentSinger,
                          currentTitle:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentTitle,
                          currentImage:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .currentImage,
                          currentIsPlaying: true,
                          duration:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .duration,
                          position:
                              Provider.of<DataListClass>(context, listen: false)
                                  .data
                                  .position,
                        );
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
