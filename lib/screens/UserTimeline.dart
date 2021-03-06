import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tweetzo/screens/HomePage.dart';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import '../Keys/secrets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'WebPage.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

String SearchUrl = "/statuses/user_timeline.json?user_id=";
String SearchQuery = '&tweet_mode=extended';
String userLattitude;
String userLongitude;
List data;

Map tweetUser;

class UserTimeline extends StatefulWidget {
  String userId;
  String userName;
  String banner;
  String profpic;
  String screenname;
  UserTimeline(
      {this.userId, this.userName, this.banner, this.profpic, this.screenname});
  @override
  State<StatefulWidget> createState() {
    return UserTimelineState();
  }
}

class UserTimelineState extends State<UserTimeline> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    debugPrint(position.toString());
    userLongitude = position.longitude.toString();
    userLattitude = position.latitude.toString();

    getData();
    // tryonr();
  }

  void getData() async {
    debugPrint(SearchUrl + widget.userId);
    Twitter twitter = new Twitter(
        secrets().CONSUMER_KEY,
        secrets().CONSUMER_SECRET,
        secrets().ACCESS_TOKEN,
        secrets().ACCESS_TOKEN_SECRET);
    var response =
        await twitter.request("GET", SearchUrl + widget.userId + SearchQuery);

    data = json.decode(response.body) as List;
    // debugPrint("Rohan" + data.toString());
    //debugPrint("Ronnnn"+data.toString());
    // List lis2 = new List.from(data[0]);
    //debugPrint("Ronnn"+lis2.toString());

    //TODO: Get User from tweet
    //tweetUser = new Map.from(data['user']);
    debugPrint(data[0]['user']['profile_image_url'].toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void _showImageFull(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => Scaffold(
                body: Center(
                  child: Hero(
                    tag: 'my-hero-animation-tag',
                    child: CachedNetworkImage(
                      imageUrl: data[0]['user']['profile_image_url']
                          .toString()
                          .replaceAll(RegExp("_normal"), ''),
                    ),
                  ),
                ),
              )));
    }

    void _showBanner(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => Scaffold(
                body: Center(
                  child: Hero(
                    tag: 'my-banner',
                    child: CachedNetworkImage(
                      imageUrl: widget.banner,
                    ),
                  ),
                ),
              )));
    }

    if (data != null) {
      return WillPopScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: Container(
            color: Theme.of(context).canvasColor,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
                  backgroundColor: Theme.of(context).canvasColor,
                  expandedHeight: 280,
                  floating: false,
                  pinned: true,
                  title: Text(widget.userName,
                      style: Theme.of(context).textTheme.title),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _showBanner(context),
                          child: Hero(
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.banner != null
                                          ? NetworkImage(widget.banner)
                                          : NetworkImage(
                                              'http://www.allwhitebackground.com/images/2/2270.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            tag: 'my-banner',
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 125,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: ShapeDecoration(
                                        shape: CircleBorder(),
                                        color: Theme.of(context).canvasColor),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: GestureDetector(
                                        onTap: () => _showImageFull(context),
                                        child: Hero(
                                          child: DecoratedBox(
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                image: DecorationImage(
                                                    image: widget.profpic !=
                                                            null
                                                        ? NetworkImage(data[0]
                                                                    ['user'][
                                                                'profile_image_url']
                                                            .toString()
                                                            .replaceAll(
                                                                RegExp(
                                                                    "_normal"),
                                                                ''))
                                                        : NetworkImage(
                                                            'http://www.allwhitebackground.com/images/2/2270.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          tag: 'my-hero-animation-tag',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(widget.userName,
                                      style: Theme.of(context).textTheme.title),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: data[0]['user']['verified'] == true
                                      ? Icon(
                                          Icons.verified_user,
                                          color: Colors.blueAccent,
                                        )
                                      : Text(""),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "@" + widget.screenname,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: NumberFormat.compact().format(
                                            data[0]['user']['followers_count']),
                                        style:
                                            Theme.of(context).textTheme.title,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: " Followers",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.normal,
                                              ))
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: NumberFormat.compact().format(
                                              data[0]['user']['friends_count']),
                                          style:
                                              Theme.of(context).textTheme.title,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: " Following",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 16.0,
                                                  fontStyle: FontStyle.normal,
                                                ))
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
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
                                      backgroundImage: NetworkImage(data[index]
                                              ['user']['profile_image_url']
                                          .toString()
                                          .replaceAll(RegExp("_normal"), '')),
                                    )),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: data[index]['user']
                                                        ['name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .title,
                                                  ),
                                                  TextSpan(
                                                      text: " @" +
                                                          data[index]['user']
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
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          WebPage(
                                                              url: retUrl(
                                                                  index)),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Linkify(
                                          text: data[index]['full_text'],
                                          style: TextStyle(fontSize: 18.0),
                                          onOpen: (link) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        WebPage(
                                                            url: link.url)));
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.retweet,
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0),
                                                ),
                                                Text(
                                                  data[index]['retweet_count']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.heart,
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0),
                                                ),
                                                Text(
                                                  data[index]['favorite_count']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                                msg: data[index]
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
                  },
                  childCount: data.length,
                )),
              ],
            ),
          ),
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
    data = null;
    return true;
  }

  String getFollowers(String numb) {
    String res = NumberFormat.compact().toString();
  }

  String retUrl(int index) {
    if (List.from(data[index]['entities']['urls']).length == 0) {
      return "0";
    } else {
      return data[index]['entities']['urls'][0]['expanded_url'].toString();
    }
  }
}
