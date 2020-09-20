import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:geolocator/geolocator.dart';
import 'package:tweetzo/NewsApi%20Screens/TopHeadlines.dart';
import 'package:tweetzo/screens/HomePage2.dart';
import 'screens/HomePage.dart';
import 'screens/TweetPage.dart';
import 'package:android_intent/android_intent.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/HomePage.dart' as hp;

void main() {
  runApp(MaterialApp(
    home: Splaash(),
    debugShowCheckedModeBanner: false,
  ));
}

class Splaash extends StatefulWidget {
  @override
  _SplaashState createState() => _SplaashState();
}

class _SplaashState extends State<Splaash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Tabs(),
      title: Text(
        "Tweetzo",
        style: TextStyle(color: Colors.white, fontSize: 28.0),
      ),
      image: Image.asset('assets/images/hashtag.png'),
      backgroundColor: Colors.lightBlue,
      photoSize: 80.0,
      loaderColor: Colors.white,
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabsState();
  }
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  BuildContext c;
  TabController controller;
  bool darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);

    _checkGps();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeEnabled
          ? ThemeData(brightness: Brightness.dark, accentColor: Colors.black54)
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.blueAccent,
              accentColor: Colors.white54),
      home: Scaffold(
        drawer: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(50.0),
                    ),
                    Image.asset(
                      'assets/images/hashtag.png',
                      height: 120.0,
                      width: 120.0,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(25.0),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Top Headlines",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => TopHeadlines(),
                          ));
                        },
                      )
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Dark Theme",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Switch(
                        value: darkThemeEnabled,
                        onChanged: (changedTheme) {
                          setState(() {
                            darkThemeEnabled = changedTheme;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                if (darkThemeEnabled == false) {
                  setState(() {
                    darkThemeEnabled = true;
                  });
                } else if (darkThemeEnabled == true) {
                  setState(() {
                    darkThemeEnabled = false;
                  });
                }
              },
              child: Text('Tweetzo')),
          bottom: TabBar(
            controller: controller,
            tabs: <Tab>[
              Tab(
                text: "Trends",
              ),
              Tab(text: "Tweets")
            ],
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[new HomePage(), new TweetPage()],
        ),
      ),
    );
  }

  Future _checkGps() async {
    if (!(await isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get current location"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = new AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
