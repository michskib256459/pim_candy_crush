import 'package:candy_crush/levels/item.dart';
import 'package:candy_crush/levels/level_info.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

const GAMEBOARD_WIDTH = 840.0;
const GAMEBOARD_RATIO = 4.0 / 3;
const GAMEBOARD_HEIGHT = GAMEBOARD_WIDTH * GAMEBOARD_RATIO;

const BLOCK_COLUMNS = 10;
const BLOCK_ROWS = 15;
const BLOCK_COUNT = BLOCK_COLUMNS * BLOCK_ROWS;
int points = 0;

int randomColor() {
  Random random = new Random();
  int randomNumber = random.nextInt(5) + 1;
  return randomNumber;
}

var _itemsList = List.generate(
    BLOCK_COUNT,
    (index) => Item(
          color: randomColor(),
          isChecked: false,
        ));

int gamePoints() {
  int points = 0;
  _itemsList.forEach((element) {
    if (element.isChecked) {
      points++;
    }
  });
  return points;
}

void _swapItems(int position) {
  if (!_itemsList[position].isChecked) {
    if ((position + 1) < BLOCK_COUNT &&
        _itemsList[position].color == _itemsList[position + 1].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position + 1] = Item(
        color: 0,
        isChecked: true,
      );
      points++;
    }
    if ((position - 1) >= 0 &&
        _itemsList[position].color == _itemsList[position - 1].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position - 1] = Item(
        color: 0,
        isChecked: true,
      );
      points++;
    }
    if ((position + BLOCK_COLUMNS) < BLOCK_COUNT &&
        _itemsList[position].color ==
            _itemsList[position + BLOCK_COLUMNS].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position + BLOCK_COLUMNS] = Item(
        color: 0,
        isChecked: true,
      );
      points++;
    }
    if ((position - BLOCK_COLUMNS) >= 0 &&
        _itemsList[position].color ==
            _itemsList[position - BLOCK_COLUMNS].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position - BLOCK_COLUMNS] = Item(
        color: 0,
        isChecked: true,
      );
      points++;
    }
  }
}

void _restartGame() {
  _itemsList.forEach((element) {
    element.isChecked = false;
  });
}

class LevelPage extends StatefulWidget {
  int moves;
  LevelInfo level;

  LevelPage({Key? key, required this.moves, required this.level})
      : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState(levelId: level.id);
}

class _LevelPageState extends State<LevelPage> {
  bool itemChecked = false;
  int movesAmount = 0;

  int levelId;

  _LevelPageState({required this.levelId});

  _showSuccessDialog() {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          _restartGame();
        },
        child: const Text('OK'));

    AlertDialog alert = AlertDialog(
      title: const Text('Game over'),
      content: Text('Your points are: ${gamePoints()}'),
      actions: [okButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight * 2,
          title: Text(
              "Poziom: ${levelId.toString()}\nPunkty: $points\nRuchy: $movesAmount/${widget.moves}"),
        ),
        body: Center(
            child: Stack(children: <Widget>[
          SizedBox(
              width: GAMEBOARD_WIDTH,
              height: GAMEBOARD_HEIGHT,
              child: Center(
                child: ReorderableGridView.count(
                  crossAxisCount: 10,
                  childAspectRatio: 1.5,
                  children: _itemsList
                      .map((Item path) => Container(
                            key: ValueKey(path),
                            child: path,
                          ))
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    Item path = _itemsList.removeAt(oldIndex);
                    _itemsList.insert(newIndex, path);
                    _swapItems(newIndex);
                    movesAmount++;
                    if (widget.moves == movesAmount) {
                      _showSuccessDialog();
                    }

                    setState(() {});
                  },
                ),
              ))
        ])));
  }
}
