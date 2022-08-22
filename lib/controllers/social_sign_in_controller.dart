import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


  class FBookSignInProvider extends ChangeNotifier {
  var _currentUser;

  UserCredential? _firebaseUser; // The firebase account created by from the
  //facebook login.

  UserCredential? get firebaseUser => _firebaseUser;
  get currentUser => _currentUser;

  bool get isSignedIn => _currentUser != null;
  bool? get isNewUser => _firebaseUser?.additionalUserInfo?.isNewUser;

  Future fBookLogin() async {
    try {
      // by default we request the email and the public profile
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // you are logged

        final userData = await FacebookAuth.i.getUserData(fields: "name,email");

        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        _currentUser = userData as GoogleSignInAccount?;

        _firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        print(result.status);
        print(result.message);
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await FacebookAuth.i.accessToken == null;
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    _firebaseUser = null;
    notifyListeners();
  }
}

