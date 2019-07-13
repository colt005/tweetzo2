import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tweetzo/screens/HomePage.dart';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import '../Keys/secrets.dart';

String SearchUrl = "/search/tweets.json?q=";
String SearchQuery =
    ' filter%3Averified%20filter%3Anews&include_entities=true&lang=en';
String userLattitude;
String userLongitude;
Map data;
List tweetStatus;
Map tweetUser;

class TrendTweets extends StatefulWidget {
  String mainQuery;
  TrendTweets({this.mainQuery});
  @override
  State<StatefulWidget> createState() {
    return TrendTweetsState();
  }
}

class TrendTweetsState extends State<TrendTweets> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.toString());
    userLongitude = position.longitude.toString();
    userLattitude = position.latitude.toString();

    getData();
    // tryonr();
  }

  void getData() async {
    debugPrint(SearchUrl + widget.mainQuery);
    Twitter twitter = new Twitter(
        secrets().CONSUMER_KEY,
        secrets().CONSUMER_SECRET,
        secrets().ACCESS_TOKEN,
        secrets().ACCESS_TOKEN_SECRET);
    var response = await twitter.request(
        "GET", SearchUrl + widget.mainQuery + SearchQuery);

    data = json.decode(response.body) as Map;
    debugPrint("Rohan" + data.toString());
    //debugPrint("Ronnnn"+data.toString());
    // List lis2 = new List.from(data[0]);
    //debugPrint("Ronnn"+lis2.toString());
    tweetStatus = new List.from(data['statuses']);

    //TODO: Get User from tweet
    //tweetUser = new Map.from(data['user']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(tweetStatus!=null) {
      return WillPopScope(
              child: Scaffold(
          appBar: AppBar(
            title: Text("#${widget.mainQuery}"),
          ),
          body: Container(
              child: ListView.builder(
            itemCount: tweetStatus.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  subtitle: Text(tweetStatus[index]['text'].toString()),
                  title: Text(tweetStatus[index]['user']['name']),
                ),
              );
            },
          )),
        ), onWillPop: _willPopcallback,
      );
    }
    
    else {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    } 
  }
  Future<bool> _willPopcallback() async{
    tweetStatus = null;
    return true;
  
  }
}
