import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweetzo/screens/TrendTweets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'WebPage.dart';

String trendUrl = "/trends/place.json?id=";

String woeidUrl = "/trends/closest.json?";
String woeidquery;
String PlaceName;
List trenddata;
List qdata;

var whoeid;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List data;
  secrets secret = secrets();

  List filterdata;
  String userLattitude;
  String userLongitude;

  Future getData() async {
    secrets secret = secrets();
    Twitter twitter = new Twitter(secret.CONSUMER_KEY, secret.CONSUMER_SECRET,
        secret.ACCESS_TOKEN, secret.ACCESS_TOKEN_SECRET);
    //twitter query req for getting the trends
    var response = await twitter.request("GET", trendUrl + whoeid);

    data = json.decode(response.body) as List;
    debugPrint(data[0].toString());
    Map lis2 = new Map.from(data[0]);
    //store the trend list from the response in trenddata list
    trenddata = new List.from(lis2['trends']);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (PlaceName == null) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    } else {
      return Container(
        child: Scaffold(
            body: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$PlaceName",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            new Expanded(
              child: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                child: ListView.builder(
                  itemCount: trenddata == null ? 0 : trenddata.length,
                  itemBuilder: (BuildContext context, int index) {
                    // title: Text(
                    //       "#${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}",
                    //       style: TextStyle(fontSize: 15.0),
                    //     )
                    return FutureBuilder(
                      builder:
                          (BuildContext context, AsyncSnapshot<String> text) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          constraints: new BoxConstraints.expand(
                            height: 200.0,
                          ),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: text.data != null
                                      ? CachedNetworkImageProvider(text.data)
                                      : CachedNetworkImageProvider(
                                          'http://www.allwhitebackground.com/images/2/2270.jpg'),
                                  fit: BoxFit.cover)),
                          child: Container(
                            color: Theme.of(context).accentColor,
                            child: ListTile(
                              title: Text(
                                "#${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () async {
                                  var response = await FlutterShareMe()
                                      .shareToSystem(
                                          msg: trenddata[index]
                                              ['url']); //share to system
                                  if (response == 'success') {
                                    print('navigate success');
                                  }
                                },
                                child: Icon(Icons.share),
                              ),
                              subtitle:
                                  Text("${trenddata[index]['tweet_volume']}"),
                              onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  TrendTweets(mainQuery: "${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}"),
                                  ));
                                
                              },
                              onLongPress: () {
                                // _showAlertDialog(
                                //     "${trenddata[index]['name'].toString()}",
                                //     trenddata[index]['url']);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => WebPage(
                                      list: trenddata,
                                      index: index,
                                      url: trenddata[index]['url']),
                                ));
                              },
                            ),
                          ),
                        );
                      },
                      future: getImage(
                          "${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}"),
                      initialData:
                          'http://www.allwhitebackground.com/images/2/2270.jpg',
                    );
                  },
                ),
                onRefresh: () async {
                  await getLocation();
                },
              ),
            )
          ],
        )),
      );
    }
  }

  // method to show alert dialog with webview on lonng press of List item
  AlertDialog _showAlertDialog(String title, String url) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Theme.of(context).primaryColorDark,
      title: AppBar(title: Text(title)),
      content: SizedBox(
        width: 400.0,
        height: 500.0,
        child: WebviewScaffold(
          resizeToAvoidBottomInset: true,
          withZoom: true,
          withJavascript: true,
          url: url,
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  //Method to get location of the user using Geolocator
  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.toString());
    userLongitude = position.longitude.toString();
    userLattitude = position.latitude.toString();
    initWoeid();
    whoeid = await getwoeid();
    await getData();

    // tryonr();
  }

  //Method to initialize the user Lattitude and Longitude
  void initWoeid() {
    woeidquery = "lat=$userLattitude&long=$userLongitude";
  }

  //Method to get the WOEID of the User location
  Future<String> getwoeid() async {
    secrets secret = secrets();
    Twitter twitter = new Twitter(secret.CONSUMER_KEY, secret.CONSUMER_SECRET,
        secret.ACCESS_TOKEN, secret.ACCESS_TOKEN_SECRET);
    var response = await twitter.request("GET", woeidUrl + woeidquery);
    data = json.decode(response.body) as List;
    debugPrint(data[0].toString());
    Map lis2 = new Map.from(data[0]);
    String woeid = lis2['woeid'].toString();
    PlaceName = lis2['name'];
    return woeid;
  }

  // Method to check if the trend keyword is news or not. Not using this since it makes the app very slow.
  Future<bool> isNews(String trendTerm) async {
    debugPrint(trendTerm);
    String NewsUrl = "https://newsapi.org/v2/everything?q=$trendTerm&apiKey=" +
        secrets().NEWS_API_KEY;
    var response = await http.get(NewsUrl);
    Map NewsData = json.decode(response.body) as Map;
    debugPrint(NewsData['totalResults'].toString());
    if (NewsData['totalResults'] < 3) {
      return false;
    } else {
      return true;
    }
  }

  //Method to make a new trend list after isNews()
  void tryonr() async {
    debugPrint(trenddata.toString());
    for (int i = 0; i < trenddata.length; i++) {
      debugPrint(trenddata[i]['name'].toString());
      var ifright = await isNews(
          trenddata[i]['name'].toString().replaceAll(RegExp("#"), ''));

      if (ifright == false) {
        trenddata.removeAt(i);
      }
      //debugPrint(qdata.toString());

    }
  }
}

Future<String> getImage(String imageTerm) async {
  //var uri = Uri.parse('https://api.cognitive.microsoft.com/bing/v7.0/images/search?q=$imageTerm&count=10');
// var request = new http.Request("GET", uri)..headers['Ocp-Apim-Subscription-Key'] = "f03e02708d8740719c4f0b3b21dcf018";
  var response = await http.get(
      'https://api.cognitive.microsoft.com/bing/v7.0/images/search?q=$imageTerm&count=10',
      headers: {
        "Ocp-Apim-Subscription-Key": "f03e02708d8740719c4f0b3b21dcf018"
      });
// Map NewsData = json.decode(response.body) as Map;
  Map data = json.decode(response.body) as Map;
//List value = List.from(data['value']);
  List value = data['value'];
  String image = value[0]['contentUrl'];
  // debugPrint(image);
//  var response = await request.body;
//  debugPrint(json.decode(response.toString()));
  String defa = 'http://www.allwhitebackground.com/images/2/2270.jpg';
  if (value.isEmpty) {
    return defa;
  } else {
    return image;
  }
}
