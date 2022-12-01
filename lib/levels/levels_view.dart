import 'package:candy_crush/levels/level_icon.dart';
import 'package:candy_crush/levels/level_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelsView extends StatefulWidget {
  LevelsView({super.key, required this.userEmail});

  String userEmail;

  @override
  State<LevelsView> createState() => _LevelsViewState();
}

class _LevelsViewState extends State<LevelsView> {
  List<int> levels = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Future<void> addLevelInfo(email, levelId, stars) {
    return FirebaseFirestore.instance
      .collection('levelInfo')
      .doc("${levelId} - ${widget.userEmail}")
      .set({
        'stars': stars
      });
  }

  void initLevels(email) {
    FirebaseFirestore.instance
      .collection('levelInfo')
      .doc("1 - ${widget.userEmail}")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (!documentSnapshot.exists) {
          addLevelInfo(email, 1, 0);
          for(int i = 2; i <= 12; i++) {
            addLevelInfo(email, i, -1);
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    initLevels(widget.userEmail);


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
            children: levels.map(
              (levelId) {
                CollectionReference levelInfo = FirebaseFirestore.instance.collection('levelInfo');
                String documentId = "${levelId} - ${widget.userEmail}";
                return FutureBuilder<DocumentSnapshot>(
                  future:  levelInfo.doc(documentId).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.hasError);
                      return LevelIcon(level: Level(levelId, -1));
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      print("Document '${documentId}' does not exist");
                      return LevelIcon(level: Level(levelId, -1));
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return LevelIcon(level: Level(levelId, data['stars']));
                    }

                    return LevelIcon(level: Level(levelId, -1));
                  }
                );
              }
            ).toList(),
          ),
        ),
      ),
    );
  }
}
