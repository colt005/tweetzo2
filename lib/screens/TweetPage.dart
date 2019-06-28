import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

String SearchUrl = "/search/tweets.json?q=";
String SearchQuery = 'filter%3Averified%20filter%3Anews&geocode=$userLattitude,$userLongitude,300km&result_type=mixed&include_entities=true&lang=en';  //filter%3Averified%20filter%3Anews
String SearchLat = "";
String SearchLong = "";
String SearchRad = "";
String userLattitude;
String userLongitude;
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

  void getData() async{
    Twitter twitter = new Twitter(secrets().CONSUMER_KEY, secrets().CONSUMER_SECRET,
        secrets().ACCESS_TOKEN, secrets().ACCESS_TOKEN_SECRET);
    var response = await twitter.request("GET", SearchUrl+SearchQuery);
    
    data = json.decode(response.body) as Map;
    debugPrint("Rohan"+data.toString());
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
    

    if(tweetStatus == null){
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ); 
    }
    else{
    return Container(
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

      )
    );
}
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