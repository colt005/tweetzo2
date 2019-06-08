import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';

import 'package:flutter_share_me/flutter_share_me.dart';

String SearchUrl = "/search/tweets.json?q=";
String SearchQuery = "filter%3Averified%20filter%3Anews";  //filter%3Averified%20filter%3Anews
String SearchLat = "";
String SearchLong = "";
String SearchRad = "";


class TweetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TweetPageState();

      }
    
    }
    
    class TweetPageState extends State<TweetPage>{

  void getData() async{
    Twitter twitter = new Twitter(secrets().CONSUMER_KEY, secrets().CONSUMER_SECRET,
        secrets().ACCESS_TOKEN, secrets().ACCESS_TOKEN_SECRET);
    var response = await twitter.request("GET", SearchUrl+SearchQuery);
    debugPrint(response.body.toString());
    //List data = json.decode(response.body) as List;
   // debugPrint(data[0].toString());
    setState(() {});

  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Text("Hello"),
    );
  }
   @override
  void initState() {
    super.initState();
    getData();
  }

}













// class TweetPage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
    
//     return Container(
//       child: Center(
//         child: Icon(Icons.airplay, size: 150.0, color: Colors.black),
//       ),
//     );
//   }


// }