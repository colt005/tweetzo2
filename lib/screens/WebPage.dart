import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  
  final String url;
  WebPage({this.url});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    if(widget.url == "0" ){
      return Scaffold(
        appBar: AppBar(
          title: Text("Oops!!"),
        ),
              body: Container(
          color: Colors.white,
          child: Center(
            child: Text("Sorry, Not Available!",style: Theme.of(context).textTheme.body1,),
          ),
        ),
      );
    }else{
      return Container(
      child: WebviewScaffold(
        url: "${widget.url}",
        resizeToAvoidBottomInset: true,
        withZoom: true,
        withJavascript: true,
        enableAppScheme: true,
        withLocalStorage: true,
        withLocalUrl: true,
        appCacheEnabled: true,
        appBar: AppBar(
          title: Text("News"),
        ),
        
      ),
    );
    }
      
    
    
  }
}

