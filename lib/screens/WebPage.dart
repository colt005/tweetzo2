import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
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

