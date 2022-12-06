import 'package:candy_crush/levels/level.dart';
import 'package:candy_crush/levels/level_info.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<StatefulWidget> createState() => BoardState();
}

class BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    final level = ModalRoute.of(context)!.settings.arguments as LevelInfo;

    return LevelPage(
      level: level,
      moves: 5,
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
