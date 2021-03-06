import 'package:flutter/material.dart';
import 'package:monitoring_scroll/contents.dart';

class MyHomePageList extends StatefulWidget {
  MyHomePageList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageListState createState() => new _MyHomePageListState();
}

class _MyHomePageListState extends State<MyHomePageList> {
  ScrollController _primaryScrollController;
  bool _isLoading = false;

  List<String> _items;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _items = List<String>();
    Contents.forEach((content) => _items.add(content));

    _primaryScrollController = PrimaryScrollController.of(context);
    _primaryScrollController.addListener(() {
      final maxScrollExtent = _primaryScrollController.position.maxScrollExtent;
      final currentPosition = _primaryScrollController.position.pixels;
      if (maxScrollExtent > 0 && (maxScrollExtent - 20.0) <= currentPosition) {
        _addContents();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _primaryScrollController,
      itemBuilder: (context, index) {
        return _buildListItem(_items[index]);
      },
      itemCount: _items.length,
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
