import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final List list;
  final int index;
  final String url;
  WebPage({this.list,this.index,this.url});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
        url: "${widget.url} filter:verified filter:news",
        resizeToAvoidBottomInset: true,
        withZoom: true,
        withJavascript: true,
        appBar: AppBar(
          title: Text("#${widget.list[widget.index]['name'].toString().replaceAll(RegExp("#"), '')}"),
        ),
        
      ),
    );
  }
}

