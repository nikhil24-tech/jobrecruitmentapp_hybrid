import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

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
      // // by default we request the email and the public profile
      // final LoginResult result = await FacebookAuth.instance.login();

      // if (result.status == LoginStatus.success) {
      //   // you are logged

      // } else {
      //   print(result.status);
      //   print(result.message);
      // }

      final fb = FacebookLogin();

// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

// Check result status
      switch (res.status) {
        case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
          final FacebookAccessToken? accessToken = res.accessToken;
          print('Access token: ${accessToken?.token}');

          // Get profile data
          final profile = await fb.getUserProfile();
          print(
              'Hello, ${profile!.name ?? "TestName"}! You ID: ${profile.userId}');

          // Get user profile image url
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');

          // Get email (since we request email permission)
          final email = await fb.getUserEmail();
          // But user can decline permission
          if (email != null) print('And your email is $email');

          final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken?.token ?? "");

          _firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

          if (_firebaseUser?.user != null) {
            _firebaseUser!.user!.updateEmail(email ?? "");
            _firebaseUser!.user!.updateDisplayName(profile.name ?? "");
            _currentUser = _firebaseUser!.user;
          }

          break;
        case FacebookLoginStatus.cancel:
        // User cancel log in
          break;
        case FacebookLoginStatus.error:
        // Log in failed
          print('Error while log in: ${res.error}');
          break;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    // await FacebookAuth.i.accessToken == null;
    // await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    _firebaseUser = null;
    notifyListeners();
  }
}
