import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:candy_crush/auth/google_auth_service.dart';
import 'package:candy_crush/main.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
    const LoginPage({Key? key}): super(key: key);

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool is_logged_in = false;

  @override
  Widget build(BuildContext context) {
    if (is_logged_in) {
        return Scaffold(
            body: const MyHomePage(title: 'Candy Crush Game Menu'),
        );
    }

    return Scaffold(
        appBar: AppBar(
        title: Text('Candy Crush'),
        ),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        "Zaloguj się, aby zagrać",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Roboto'
                        )
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SignInButton(
                        Buttons.Google,
                        text: "Zaloguj się przez Google",
                        onPressed: () async {
                            GoogleAuthService service = new GoogleAuthService();
                            try {
                                await service.signInwithGoogle();
                                setState(() {
                                    is_logged_in = true;
                                });
                            } catch (e) {
                                if (e is FirebaseAuthException) {
                                    print(e.message!);
                                }
                            }
                        },
                    )
                ),
            ])
        )
    );
  } 
}
