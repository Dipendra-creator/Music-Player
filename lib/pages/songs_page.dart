import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongsPage extends StatelessWidget {
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
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    // width: 150,
                    child: ListView.builder(
                      itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => MusicCard()
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

class MusicCard extends StatelessWidget {
  const MusicCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,

      child: _buildCard("name", "context"),
    );
  }
}

Widget _buildCard(String name, context) {
  return Padding(
    padding: EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
    child: InkWell(
      onTap: () {},
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
          color: Colors.blueAccent,
        ),
      ),
    ),
  );
}
