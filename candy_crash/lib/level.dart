import 'package:candy_crash/item.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

const GAMEBOARD_WIDTH = 840.0;
const GAMEBOARD_RATIO = 4.0 / 3;
const GAMEBOARD_HEIGHT = GAMEBOARD_WIDTH * GAMEBOARD_RATIO;

const BLOCK_COLUMNS = 10;
const BLOCK_ROWS = 15;
const BLOCK_COUNT = BLOCK_COLUMNS * BLOCK_ROWS;

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
    }
    if ((position - 1) >= 0 &&
        _itemsList[position].color == _itemsList[position - 1].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position - 1] = Item(
        color: 0,
        isChecked: true,
      );
    }
    if ((position + BLOCK_COLUMNS) < BLOCK_COUNT &&
        _itemsList[position].color ==
            _itemsList[position + BLOCK_COLUMNS].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position + BLOCK_COLUMNS] = Item(
        color: 0,
        isChecked: true,
      );
    }
    if ((position - BLOCK_COLUMNS) >= 0 &&
        _itemsList[position].color ==
            _itemsList[position - BLOCK_COLUMNS].color) {
      _itemsList[position].isChecked = true;
      _itemsList[position - BLOCK_COLUMNS] = Item(
        color: 0,
        isChecked: true,
      );
    }
  }
}

void _restartGame() {
  _itemsList.forEach((element) {
    element.isChecked = false;
  });
}

class LevelPage extends StatefulWidget {
  int? moves;

  LevelPage({Key? key, this.moves}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  bool itemChecked = false;
  int movesAmount = 0;

  _showSuccessDialog() {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          _restartGame();
        },
        child: Text('OK'));

    AlertDialog alert = AlertDialog(
      title: Text('Game over'),
      content: Text('Your points are: ' + gamePoints().toString()),
      actions: [okButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Poziom"),
        ),
        body: Center(
            child: Stack(children: <Widget>[
          Container(
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
