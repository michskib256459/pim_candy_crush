import 'package:flutter/material.dart';
import 'package:candy_crash/level.dart';

class Item extends StatefulWidget {
  int? color;
  int? x;
  int? y;
  bool isChecked = false;
  late Widget _widget;

  Item({this.color});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int getColor(color) {
    if (color == 1) {
      return 0x00FFFF;
    }
    if (color == 2) {
      return 0x00FF00;
    }

    if (color == 3) {
      return 0xFF00FF;
    }

    if (color == 4) {
      return 0xFF0000;
    }

    if (color == 5) {
      return 0xFFFF00;
    }

    return 0xC9C9C9;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
              color: widget.isChecked == true
                  ? Colors.grey
                  : Color(getColor(widget.color)).withOpacity(1.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0)))),
    );
  }
}
