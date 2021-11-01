import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
    TabController _tabController;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF2196F3)),
      // color: Colors.blue,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
                Icons.search,
                size: 35,
                color: Colors.black45
            ),
            onPressed: () {
              print('Search');
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.queue_music,
                  size: 35,
                  color: Colors.black45
              ),
              onPressed: () {
                print('Music Queue');
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 15,),
            Text(
              'Browse',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 15,),

            /*TODO: TabBar */
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.blueAccent,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text(
                    'Songs',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black45,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Playlist',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black45,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Podcast',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black45,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black45,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Downloaded',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xFF2196F3),
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
      ),
    );
  }
}
