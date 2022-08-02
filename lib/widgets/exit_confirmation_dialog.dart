import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/style.dart';
import '../controllers/social_sign_in_controller.dart';
import '../screens/user_type_select.dart';

exitConfirmationDialog(BuildContext context) async {
  return await (showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: kSmallButtonStyle.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(kDeleteRedColor)),
                  child: Text('Sign Out'),
                  onPressed: () async {
                    final fBookSignInProvider =
                        Provider.of<FBookSignInProvider>(context,
                            listen: false);
                         fBookSignInProvider.isSignedIn == true // if logged in with facebook
                            ? await fBookSignInProvider.logout() // logout from facebook
                            : await FirebaseAuth.instance.signOut(); // logout as email user

                    //Firebase Auth Sign Out for email users

                    final userDataCache = await SharedPreferences.getInstance();
                    final isUserCacheCleared = await userDataCache.clear();
                    if (isUserCacheCleared == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserTypeSelectScreen()));
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserTypeSelectScreen()));
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: kSmallButtonStyle,
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
          ],
        ),
      )) ??
      false;
}
