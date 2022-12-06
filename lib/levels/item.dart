import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  int? color;
  int? x;
  int? y;
  bool isChecked = false;
  late Widget _widget;

  Item({super.key, this.color, required this.isChecked});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int getColor(color, isChecked) {
    if (!isChecked) {
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
    }

    if (color == 0) {
      isChecked = true;
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
              color: Color(getColor(widget.color, widget.isChecked))
                  .withOpacity(1.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0)))),
    );
  }
}
