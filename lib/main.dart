import 'package:flutter/material.dart';
import 'screens/HomePage.dart';
import 'screens/TweetPage.dart';

void main() {
  runApp(MaterialApp(home: Tabs(),
  debugShowCheckedModeBanner: false,));
}

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabsState();
  }
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController controller;
  bool darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkThemeEnabled ? ThemeData(
        brightness: Brightness.dark,
        
          accentColor: Colors.black54
        
      ) : ThemeData(
          brightness: Brightness.light,
          
          primaryColor: Colors.blueAccent,
        accentColor: Colors.white54
      ),
      
      home: Scaffold(
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
          actions: <Widget>[
            Row(
              children: <Widget>[
                Text("Dark Theme"),
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
}
