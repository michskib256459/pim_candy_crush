

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId: "103918647242-7i4t2agr1tekoubpn82jm9cs5d7jmm06.apps.googleusercontent.com"
    );

    Future<String?> signInwithGoogle() async {
        try {
            final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
            final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
            final AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
            );
            await _auth.signInWithCredential(credential);
        } on FirebaseAuthException catch (e) {
            print(e.message);
            throw e;
        }
    }

    Future<void> signOutFromGoogle() async{
        await _googleSignIn.signOut();
        await _auth.signOut();
    }
}