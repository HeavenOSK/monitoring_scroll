import 'package:flutter/material.dart';
import 'package:monitoring_scroll/contents.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  bool _isLoading = false;

  List<String> _items;

  @override
  void initState() {
    _items = List<String>();
    Contents.forEach((content) => _items.add(content));

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      if (maxScrollExtent > 0 &&
          (maxScrollExtent - 20.0) <= currentPosition) {
        _addContents();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return _buildListItem(_items[index]);
        },
        itemCount: _items.length,
      ),
    );
  }

  Widget _buildListItem(String content) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(12.0),
      child: Text(content),
    );
  }

  _addContents() {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        Contents.forEach((content) => _items.add(content));
      });
      _isLoading = false;
    });
  }
}
