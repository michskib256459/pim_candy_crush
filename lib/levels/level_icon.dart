import 'package:candy_crush/levels/level_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelIcon extends StatelessWidget {
  final LevelInfo level;
  final double size;
  final Function updateLevelsView;
  final String userEmail;

  const LevelIcon({super.key, required this.level, required this.updateLevelsView, required this.userEmail, this.size = 24});

  updateScore(score) async {
    int stars = -1;
    if (score < 5) {
      stars = 0;
    }
    else if (score < 9) {
      stars = 1;
    }
    else if (score < 14) {
      stars = 2;
    }
    else {
      stars = 3;
    }


    // Update stars for level if score is better
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('levelInfo')
      .where('email', isEqualTo: userEmail)
      .where('levelId', isEqualTo: level.id)
      .where('stars', isLessThan: stars)
      .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs[0]
        .reference
        .update({'stars': stars});
    }


    // Unlock next level if blocked and stars > 0
    if ( stars > 0 ) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('levelInfo')
            .where('email', isEqualTo: userEmail)
            .where('levelId', isEqualTo: level.id + 1)
            .where('stars', isEqualTo: -1)
            .get();

          if (querySnapshot.docs.isNotEmpty) {
            await querySnapshot.docs[0]
              .reference
              .update({'stars': 0});
          }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: level.stars > 0
                ? Theme.of(context).primaryColor
                : level.stars < 0
                    ? const Color(0xFF878787)
                    : const Color(0xFFA5D5A6),
            borderRadius: BorderRadius.circular(size / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: level.stars >= 0
              ? ListView(children: <Widget>[
                  Center(
                    heightFactor: 1.5,
                    child: Text(
                      level.id.toString(),
                      style: TextStyle(
                        color: level.stars >= 0
                            ? Colors.white
                            : const Color.fromRGBO(0, 0, 0, 0.25),
                        fontSize: size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star,
                          color:
                              level.stars >= 1 ? Colors.yellow : Colors.white,
                          size: size * 3 / 4),
                      Icon(Icons.star,
                          color:
                              level.stars >= 2 ? Colors.yellow : Colors.white,
                          size: size * 3 / 4),
                      Icon(Icons.star,
                          color:
                              level.stars == 3 ? Colors.yellow : Colors.white,
                          size: size * 3 / 4),
                    ],
                  )
                ])
              : Center(
                  heightFactor: 1.5,
                  child: Text(
                    level.id.toString(),
                    style: TextStyle(
                      color: level.stars >= 0
                          ? Colors.white
                          : const Color.fromRGBO(0, 0, 0, 0.25),
                      fontSize: size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        onTap: () async {
          if (level.stars >= 0) {
            var val = await Navigator.pushNamed(context, '/level', arguments: level);
            await updateScore(val);
            updateLevelsView();
          }
        },
      ),
    );
  }
}
