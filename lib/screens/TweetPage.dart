import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'WebPage.dart';

String SearchUrl = "/search/tweets.json?q=";
String SearchQuery = 'filter%3Averified%20filter%3Anews&geocode=$userLattitude,$userLongitude,300km&include_entities=true&lang=en';  //filter%3Averified%20filter%3Anews
String SearchLat = "";
String SearchLong = "";
String SearchRad = "";
String userLattitude;
String userLongitude;
Map data;
List tweetStatus;
Map tweetUser;
// Pixabay API key 12901536-156cd75b50243be5eaccdfaac
//Azure api key f03e02708d8740719c4f0b3b21dcf018


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
    

    if (tweetStatus != null) {
      return WillPopScope(
        child: Scaffold(
          
          body: Container(
              child: ListView.builder(
            itemCount: tweetStatus.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(tweetStatus[index]
                                    ['user']['profile_image_url']),
                              )),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: tweetStatus[index]['user']
                                                  ['name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title,
                                            ),
                                            TextSpan(
                                                text: " @" +
                                                    tweetStatus[index]['user']
                                                        ['screen_name'],
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey)),
                                          ]),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        flex: 5,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    WebPage(url: retUrl(index)),
                                              ));
                                            },
                                            child: Icon(
                                              Icons.open_in_browser,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Linkify(
                                    text: tweetStatus[index]['text'],
                                    style: TextStyle(fontSize: 18.0),
                                    onOpen: (link) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            WebPage(url: retUrl(index)),
                                      ));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.retweet,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                          ),
                                          Text(
                                            tweetStatus[index]['retweet_count']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.heart,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                          ),
                                          Text(
                                            tweetStatus[index]['favorite_count']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          FlatButton(
                                            child: Icon(
                                              FontAwesomeIcons.shareAlt,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () async {
                                              var response =
                                                  await FlutterShareMe()
                                                      .shareToSystem(
                                                          msg:
                                                              tweetStatus[index]
                                                                  ['text']);
                                              if (response == 'success') {
                                                print('navigate success');
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
//CachedNetworkImage(imageUrl: tweetStatus[index]['user']['profile_background_image_url_https'],
              // Card(
              //   child: ListTile(
              //     subtitle: Linkify(
              //       text: tweetStatus[index]['text'],
              //       onOpen: (link){
              //         Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (BuildContext context) => WebPage(

              //                         url: link.toString()),
              //                   ));
              //       },
              //     ),
              //     // Text(tweetStatus[index]['text'].toString()),
              //     title: Text(tweetStatus[index]['user']['name']),
              //   ),
              // );
            },
          )),
        ),
        onWillPop: _willPopcallback,
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }

  Future<bool> _willPopcallback() async {
    tweetStatus = null;
    return true;
  }

  String retUrl(int index) {
    if (List.from(tweetStatus[index]['entities']['urls']).length == 0) {
      return "0";
    } else {
      return tweetStatus[index]['entities']['urls'][0]['expanded_url']
          .toString();
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


