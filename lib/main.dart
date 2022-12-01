import 'package:candy_crush/game.dart';
import 'package:candy_crush/levels/levels_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:candy_crush/auth/login.dart';
import 'package:candy_crush/auth/google_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  bool is_logged_in = false;

  Future<void> addLevelInfo(email, levelId, stars) {
    return FirebaseFirestore.instance
      .collection('levelInfo')
      .doc("${levelId} - ${email}")
      .set({
        'stars': stars
      });
  }

  Future<void> initLevels(email) {
    return FirebaseFirestore.instance
      .collection('levelInfo')
      .doc("1 - ${email}")
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

    User? user = FirebaseAuth.instance.currentUser;

    if ( !is_logged_in && user != null ) {
      setState(() {
        is_logged_in = true;
      });
    }

    if (is_logged_in) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 40.0),
              child: GestureDetector(
                onTap: () async {
                  GoogleAuthService service = new GoogleAuthService();
                  try {
                    await service.signOutFromGoogle();
                    setState(() {
                        is_logged_in = false;
                    });
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                        print(e.message!);
                    }
                  }
                },
                child: Icon(Icons.logout),
              )
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future:  initLevels(user!.email!),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return LevelsView(userEmail: user!.email!);
          }
        ),
      );
    }

    return Scaffold(
      body: const LoginPage(),
    );

  }
}
