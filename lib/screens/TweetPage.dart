import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

String SearchUrl = "/search/tweets.json?q=";
String SearchQuery = "filter%3Averified%20filter%3Anews";  //filter%3Averified%20filter%3Anews
String SearchLat = "";
String SearchLong = "";
String SearchRad = "";
Map data;
List tweetStatus;
Map tweetUser;


class TweetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TweetPageState();

      }
    
    }
    
    class TweetPageState extends State<TweetPage>{
       @override
  void initState() {
    super.initState();
    getData();
  }
    

  void getData() async{
    Twitter twitter = new Twitter(secrets().CONSUMER_KEY, secrets().CONSUMER_SECRET,
        secrets().ACCESS_TOKEN, secrets().ACCESS_TOKEN_SECRET);
    var response = await twitter.request("GET", SearchUrl+SearchQuery);
    debugPrint(response.body.toString());
    data = json.decode(response.body) as Map;
    //debugPrint("Ronnnn"+data.toString());
   // List lis2 = new List.from(data[0]);
    //debugPrint("Ronnn"+lis2.toString());
    tweetStatus = new List.from(data['statuses']);
    for(int i=0;i<tweetStatus.length;i++){
      tweetUser = new Map.from(data['statuses'][i]['user']);
    }
    //TODO: Get User from tweet
    //tweetUser = new Map.from(data['user']);
    debugPrint("Ronnnn"+tweetUser.toString());


    setState(() {});

  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: ListView.builder(
        itemCount: tweetStatus.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(tweetStatus[index]['text'].toString()),
              
              
            ),

          );
        },

      )
    );
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