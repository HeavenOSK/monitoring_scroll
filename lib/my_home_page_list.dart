import 'package:flutter/material.dart';
import 'package:monitoring_scroll/contents.dart';

import 'dart:math' as math;

import 'package:monitoring_scroll/custom_bouncing_physics.dart';

class MyHomePageList extends StatefulWidget {
  MyHomePageList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageListState createState() => new _MyHomePageListState();
}

class _MyHomePageListState extends State<MyHomePageList> {
  ScrollController _primaryScrollController;

  List<int> _items;

  @override
  void initState() {
    _items = List.generate(5000, (index) => index);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: CustomBouncingPhysics(),
      controller: _primaryScrollController,
      itemBuilder: (context, index) {
        return _buildListItem(_items[index]);
      },
      itemCount: _items.length,
    );
  }

  Widget _buildListItem(int number) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(12.0),
      child: Text(number.toString()),
    );
  }
}

class CustomSimulation extends Simulation {
  final double initialPosition;
  final double velocity;

  CustomSimulation({
    this.initialPosition,
    this.velocity,
  });

  @override
  double x(double time) {
    var max = math.max(
        math.min(initialPosition, 0.0), initialPosition + velocity * time);

    // print(max.toString());

    return max;
  }

  @override
  double dx(double time) {
    // print(velocity.toString());
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomSimulation(
      initialPosition: position.pixels,
      velocity: velocity,
    );
  }
}
