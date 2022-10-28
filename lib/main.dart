import 'package:candy_crush/game.dart';
import 'package:candy_crush/levels/levels_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(76, 175, 80, .1),
  100: const Color.fromRGBO(76, 175, 80, .2),
  200: const Color.fromRGBO(76, 175, 80, .3),
  300: const Color.fromRGBO(76, 175, 80, .4),
  400: const Color.fromRGBO(76, 175, 80, .5),
  500: const Color.fromRGBO(76, 175, 80, .6),
  600: const Color.fromRGBO(76, 175, 80, .7),
  700: const Color.fromRGBO(76, 175, 80, .8),
  800: const Color.fromRGBO(76, 175, 80, .9),
  900: const Color.fromRGBO(76, 175, 80, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candy Crush',
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF4CAF50, color),
          scaffoldBackgroundColor: const Color.fromRGBO(231, 244, 232, 1),
          fontFamily: 'Roboto'),
      home: const MyHomePage(title: 'Candy Crush Game Menu'),
      routes: {
        '/level': (context) => const Board(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const LevelsView(),
    );
  }
}
