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

  refreshWidget() {
    setState(() {});
  }

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
            children: levels.map(
              (levelId) {
                CollectionReference levelInfo = FirebaseFirestore.instance.collection('levelInfo');
                String documentId = "${levelId} - ${widget.userEmail}";
                return FutureBuilder<QuerySnapshot>(
                  future:  levelInfo.where('email', isEqualTo: widget.userEmail)
                                    .where('levelId', isEqualTo: levelId)
                                    .get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.hasError);
                      return LevelIcon(
                        level: LevelInfo(levelId, -1),
                        updateLevelsView: refreshWidget,
                        userEmail: widget.userEmail
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                      return LevelIcon(
                        level: LevelInfo(levelId, data['stars']),
                        updateLevelsView: refreshWidget,
                        userEmail: widget.userEmail
                      );
                    }

                    return LevelIcon(
                      level: LevelInfo(levelId, -1),
                      updateLevelsView: refreshWidget,
                      userEmail: widget.userEmail
                    );
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
