import 'package:candy_crush/levels/level_icon.dart';
import 'package:candy_crush/levels/level_info.dart';
import 'package:flutter/material.dart';

class LevelsView extends StatefulWidget {
  const LevelsView({super.key});

  @override
  State<LevelsView> createState() => _LevelsViewState();
}

class _LevelsViewState extends State<LevelsView> {
  List<LevelInfo> levels = <LevelInfo>[
    LevelInfo(1, 3),
    LevelInfo(2, 3),
    LevelInfo(3, 3),
    LevelInfo(4, 1),
    LevelInfo(5, 3),
    LevelInfo(6, 3),
    LevelInfo(7, 2),
    LevelInfo(8, 2),
    LevelInfo(9, 3),
    LevelInfo(10, 0),
    LevelInfo(11, -1),
    LevelInfo(12, -1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: const Text(
          'Poziomy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 4,
            children: levels.map((e) => LevelIcon(level: e)).toList(),
          ),
        ),
      ),
    );
  }
}
