import 'package:candy_crush/levels/level.dart';
import 'package:candy_crush/levels/level_icon.dart';
import 'package:flutter/material.dart';

class LevelsView extends StatefulWidget {
  const LevelsView({super.key});

  @override
  State<LevelsView> createState() => _LevelsViewState();
}

class _LevelsViewState extends State<LevelsView> {
  List<Level> levels = <Level>[
    Level(1, 3),
    Level(2, 3),
    Level(3, 3),
    Level(4, 1),
    Level(5, 3),
    Level(6, 3),
    Level(7, 2),
    Level(8, 2),
    Level(9, 3),
    Level(10, 0),
    Level(11, -1),
    Level(12, -1),
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
