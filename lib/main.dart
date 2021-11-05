import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:smash_media/pages/music_list.dart';
import './pages/songs_page.dart';
import 'package:provider/provider.dart';
import 'package:smash_media/pages/songs_page.dart';

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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.search, size: 35, color: Colors.black45),
          onPressed: () {
            print('Search');
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.queue_music, size: 35, color: Colors.black45),
            onPressed: () {
              print('Music Queue');
            },
          ),
        ],
      ),

      body: ListView(
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

      bottomNavigationBar: SizedBox(
        height: 150,
        child: bottomPlayer(),
      )
    );
  }
}

class bottomPlayer extends StatelessWidget {
  const bottomPlayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            value: 0,
            onChanged: (value) {},

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
                      image: NetworkImage(Provider.of<DataListClass>(context).data.currentImage),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      Provider.of<DataListClass>(context).data.currentSinger,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Provider.of<DataListClass>(context).data.btnIcon),
                  onPressed: () {

                  },
                  iconSize: 42,
                  color: Color(0xFFFF9544),
                )
              ],
            ),
          )
        ],
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
