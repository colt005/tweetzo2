import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tweetzo/screens/WebPage.dart';
import '../screens/HomePage.dart';
import 'package:cached_network_image/cached_network_image.dart';

String country = 'in';

Map data;
final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

class TopHeadlines extends StatefulWidget {
  @override
  _TopHeadlinesState createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  String category;
  Future getData() async {
    var response = await http.get(
        Uri.encodeFull('https://newsapi.org/v2/top-headlines?country=$country'),
        headers: {
          "Accept": "application/json",
          "X-Api-Key": "9973f0618b1f4f9483f05e9f95885a73"
        });

    data = json.decode(response.body);

    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[Text("Top Headlines"), Icon(Icons.trending_up)],
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (data == null) {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return ListView.builder(
                  itemCount: data["articles"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 1.8,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                            ),
                                            child: data["articles"][index]
                                                        ["title"] !=
                                                    null
                                                ? Text(
                                                    data["articles"][index]
                                                        ["title"],
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Text(""),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: new EdgeInsets.only(
                                                    left: 4.0),
                                                child: new Text(
                                                  timeago.format(DateTime.parse(
                                                      data["articles"][index]
                                                          ["publishedAt"])),
                                                  style: new TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    new EdgeInsets.all(5.0),
                                                child: data["articles"][index]
                                                                ["source"]
                                                            ["name"] !=
                                                        null
                                                    ? Text(
                                                        "by " +
                                                            data["articles"]
                                                                        [index]
                                                                    ["source"]
                                                                ["name"],
                                                        style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      )
                                                    : Text(""),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4.0),
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: data["articles"]
                                                      [index]["urlToImage"],
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 4.0,
                                                bottom: 4.0),
                                            child: data["articles"][index]
                                                        ["description"] !=
                                                    null
                                                ? Text(
                                                    data["articles"][index]
                                                        ["description"],
                                                    style: new TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Text(""),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        WebPage(
                                                            url:
                                                                data["articles"]
                                                                        [index]
                                                                    ["url"])));
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );

                    // ListTile(

                    //   title: Text("${snapshot.data["articles"][index]["title"]}"),

                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
