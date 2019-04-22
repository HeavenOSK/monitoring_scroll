import 'package:flutter/material.dart';
import 'package:monitoring_scroll/contents.dart';
import 'package:monitoring_scroll/my_home_page_list.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title is different"),
      ),
      body: MyHomePageList(),
    );
  }
}
