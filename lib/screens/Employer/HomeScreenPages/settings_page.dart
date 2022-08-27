import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../controllers/login_signup_validators.dart';
import '../../../controllers/social_sign_in_controller.dart';
import '../../../widgets/motion_toasts.dart';
import '../../user_type_select.dart';
import '../create_profile_emp_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _settingsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _settingsFormKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 33),
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 13),
                Text("JobKart", style: kSmallLogoTextStyle),
                SizedBox(height: 37),
                ElevatedButton(
                  style: kBigButtonStyle,
                  child: Text("Edit Profile"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployerCreateProfileScreen(
                            isNavigatingFromSettingsPage: true),
                      ),
                    );
                  },
                ),
                SizedBox(height: 21),
                TextFormField(
                  obscureText: true,
                  validator: notNullValidator,
                  controller: passwordController,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: "Old Password"),
                ),
                SizedBox(height: 13),
                TextFormField(
                  obscureText: true,
                  validator: notNullValidator,
                  controller: newPasswordController,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: "Enter New Password"),
                ),
                SizedBox(height: 13),
                TextFormField(
                  obscureText: true,
                  validator: notNullValidator,
                  controller: confirmPasswordController,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: "Confrim New Password"),
                ),
                SizedBox(height: 21),
                ElevatedButton(
                  style: kBigButtonStyle,
                  child: Text("Change Password"),
                  onPressed: () {
                    if (_settingsFormKey.currentState!.validate()) {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        changePassword(
                            password: passwordController.text,
                            newPassword: newPasswordController.text);
                        clearTextFields();
                      } else {
                        clearTextFields();
                        errorToast(context, "passwords don't match",
                            kBigButtonTextStyle);
                      }
                    }
                  },
                ),
                SizedBox(height: 21),
                ElevatedButton(
                  style: kBigButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(kDeleteRedColor),
                  ),
                  child: Text("Sign Out"),
                  onPressed: () async {
                    final fBookSignInProvider =
                    Provider.of<FBookSignInProvider?>(context,
                        listen: false);
                    (fBookSignInProvider?.isSignedIn ?? false) ==
                        true //if signed in with facebook
                        ? await fBookSignInProvider?.logout()
                        : await FirebaseAuth.instance
                        .signOut(); //email user signout
                    final userDataCache = await SharedPreferences.getInstance();
                    final isUserCacheCleared = await userDataCache.clear();
                    if (isUserCacheCleared == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserTypeSelectScreen()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changePassword(
      {required String password, required String newPassword}) async {
    User user = await FirebaseAuth.instance.currentUser!;
    String email = user.email!;

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_) {
        successToast(context, "Password Changed", kBigButtonTextStyle);
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorToast(context, "Social login or incorect password entered",
            kBigButtonTextStyle);
      } else if (e.code == 'wrong-password') {
        errorToast(context, "Social login or incorect password entered",
            kBigButtonTextStyle);
      }
    }
  }

  //clear controller texts
  void clearTextFields() {
    passwordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
