import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:math' as ma;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:oauth/oauth.dart';
import 'package:tweetzo/screens/TrendTweets.dart';
import 'package:oauth/oauth.dart' as oauth;
import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../Keys/secrets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdownfield/dropdownfield.dart';

import 'WebPage.dart';
//"Your Location","Cape Town","Tokyo","New York","Singapore","Seoul","Melbourne","London","Miami","Barcelona","Buenos Aires","Mumbai","Bangalore","CHennai","Hyderabad"

String trendUrl = "/trends/place.json?id=";
String selectedCity = "Your Location";
String woeidUrl = "/trends/closest.json?";
String woeidquery;
String PlaceName;
List trenddata;
List qdata;
String dropdownvalue = "Your Location";

List<String> cities = [
  "Your Location",
  "Cape Town",
  "Tokyo",
  "New York",
  "Singapore",
  "Seoul",
  "Melbourne",
  "Delhi",
  "London",
  "Miami",
  "Barcelona",
  "Buenos Aires",
  "Mumbai",
  "Bangalore",
  "Chennai",
];

var whoeid;

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage2State();
  }
}

class _HomePage2State extends State<HomePage2> {
  Map<String, dynamic> formdata;
  _HomePage2State() {
    formdata = {'City': 'Your Location'};
  }
  String genRandom() {
    var rng = new ma.Random();
    return rng.nextInt(8000).toString();
  }

  secrets secret = secrets();

  List filterdata;
  String userLattitude;
  String userLongitude;
  List data;
  Future getData() async {
    secrets secret = secrets();
    Twitter twitter = new Twitter(secret.CONSUMER_KEY, secret.CONSUMER_SECRET,
        secret.ACCESS_TOKEN, secret.ACCESS_TOKEN_SECRET);
    //twitter query req for getting the trends
    var response = await twitter.request("GET", trendUrl + whoeid);

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body) as List;
        Map lis2 = new Map.from(data[0]);
        //store the trend list from the response in trenddata list
        trenddata = new List.from(lis2['trends']);
      });
    } else {
      setState(() {
        selectedCity = "Your Location";

        getLocation();
      });
    }
    setState(() {
      data = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void dispose() {
    super.dispose();
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
              child: DropDownField(
                value: selectedCity,
                icon: Icon(Icons.location_city),
                labelText: "Choose City",
                items: cities,
                strict: true,
                required: true,
                onValueChanged: (value) {
                  setState(() {
                    selectedCity = value;

                    getLocation();
                  });
                },
              ),
            ),
            new Expanded(
              child: data == null
                  ? LiquidPullToRefresh(
                      color: Theme.of(context).backgroundColor,
                      backgroundColor: Colors.blue,
                      showChildOpacityTransition: false,
                      child: ListView.builder(
                        itemCount: trenddata == null ? 0 : trenddata.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder(
                            builder: (BuildContext context,
                                AsyncSnapshot<String> text) {
                              return Stack(
                                children: <Widget>[
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      margin: prefix0.EdgeInsets.only(top:61.0,right: 12.0,left: 12.0,bottom: 12.0),
                                      child: Image(image: text.data != null
                                          ? CachedNetworkImageProvider(text.data)
                                          : CachedNetworkImageProvider(
                                              'http://www.allwhitebackground.com/images/2/2270.jpg'),fit: BoxFit.cover,),
                                    ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)
                                            ),
                                            elevation: 5.0,
                                            margin: EdgeInsets.all(10),
                                    
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0)),
                                      color: Theme.of(context).accentColor,
                                    ),
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
                                                  msg: trenddata[index][
                                                      'url']); //share to system
                                          if (response == 'success') {
                                            print('navigate success');
                                          }
                                        },
                                        child: Icon(Icons.share),
                                      ),
                                      subtitle: trenddata[index]
                                                  ['tweet_volume'] !=
                                              null
                                          ? Text( NumberFormat.compact().format(trenddata[index]['tweet_volume'])+" Tweets"
                                              )
                                          : Text(genRandom()+" Tweets"),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              TrendTweets(
                                                  mainQuery:
                                                      "${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}"),
                                        ));
                                      },
                                    ),
                                  ),
                                ],
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
                    )
                  : Center(child: Text("data")),
            )
          ],
        )),
      );
    }
  }

  // method to show alert dialog with webview on lonng press of List item
  AlertDialog _showAlertDialog(String title, BuildContext con) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Theme.of(context).primaryColorDark,
      title: AppBar(title: Text(title)),
      content: SizedBox(
        width: 400.0,
        height: 500.0,
        child: ListTile(
          title: Text("data"),
        ),
      ),
    );
    showDialog(context: con, builder: (_) => alertDialog);
  }

  //Method to get location of the user using Geolocator
  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //debugPrint(position.toString());
    userLongitude = position.longitude.toString();
    userLattitude = position.latitude.toString();
    initWoeid();
    whoeid = await getwoeid();
    getData();

    // tryonr();
  }

  //Method to initialize the user Lattitude and Longitude
  void initWoeid() {
    woeidquery = "lat=$userLattitude&long=$userLongitude";
  }

  //Method to get the WOEID of the User location
  Future<String> getwoeid() async {
    secrets secret = secrets();
    if (selectedCity == "Your Location") {
      Twitter twitter = new Twitter(secret.CONSUMER_KEY, secret.CONSUMER_SECRET,
          secret.ACCESS_TOKEN, secret.ACCESS_TOKEN_SECRET);
      var response = await twitter.request("GET", woeidUrl + woeidquery);
      List data2 = json.decode(response.body) as List;
      //  debugPrint(data[0].toString());
      Map lis2 = new Map.from(data2[0]);
      String woeid = lis2['woeid'].toString();
      PlaceName = lis2['name'];
      return woeid;
    } else {
      var url = "http://databaseron.000webhostapp.com/woeidquery.php";
      var response = await http.post(url, body: {
        "Paralocation": selectedCity,
      });

      var result = json.decode(response.body);
      Map locationmap = result['location'];
      String woeid = locationmap['woeid'].toString();
      debugPrint(woeid);

      return woeid;
    }
  }

  // Method to check if the trend keyword is news or not. Not using this since it makes the app very slow.
  Future<bool> isNews(String trendTerm) async {
    // debugPrint(trendTerm);
    String NewsUrl = "https://newsapi.org/v2/everything?q=$trendTerm&apiKey=" +
        secrets().NEWS_API_KEY;
    var response = await http.get(NewsUrl);
    Map NewsData = json.decode(response.body) as Map;
    //debugPrint(NewsData['totalResults'].toString());
    if (NewsData['totalResults'] < 3) {
      return false;
    } else {
      return true;
    }
  }

  //Method to make a new trend list after isNews()
  void tryonr() async {
    //debugPrint(trenddata.toString());
    for (int i = 0; i < trenddata.length; i++) {
      // debugPrint(trenddata[i]['name'].toString());
      var ifright = await isNews(
          trenddata[i]['name'].toString().replaceAll(RegExp("#"), ''));

      if (ifright == false) {
        trenddata.removeAt(i);
      }
    }
  }
}

Future<String> getImage(String imageTerm) async {
  var response = await http.get(
      'https://api.cognitive.microsoft.com/bing/v7.0/images/search?q=$imageTerm&count=10',
      headers: {
        "Ocp-Apim-Subscription-Key": "f03e02708d8740719c4f0b3b21dcf018"
      });
  Map data = json.decode(response.body) as Map;
  List value = data['value'];
  String image = value[0]['contentUrl'];
  String defa = 'http://www.allwhitebackground.com/images/2/2270.jpg';
  if (value.isEmpty) {
    return defa;
  } else {
    return image;
  }
}

// DropdownButton(
//                 isExpanded: true,
//                 icon: Icon(Icons.location_on),
//                 value: dropdownvalue,
//                 items: <String>["Your Location","Cape Town","Tokyo","New York","Singapore","Seoul","Melbourne","London","Miami","Barcelona","Buenos Aires","Mumbai","Bangalore","CHennai","Hyderabad"].map<DropdownMenuItem<String>>((String value){
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Center(child: Text(value)),
//                   );
//               }).toList(),
//               onChanged: (String newvalue) {
//                 setState((){

//                   dropdownvalue = newvalue;

//                 });
//               },),

// CachedNetworkImage(
//   imageUrl: "http://notAvalid.uri",
//   imageBuilder: (context, imageProvider) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: imageProvider,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),
// );
