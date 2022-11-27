import 'package:flutter/material.dart';
import 'package:candy_crash/level.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LevelPage(
        moves: 5,
      ),
    );
  }
}
