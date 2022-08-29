import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/style.dart';
import '../controllers/social_sign_in_controller.dart';
import '../controllers/navigate_to_home_screen.dart';
import '../models/jk_user.dart';
import '../services/job_kart_db_service.dart';
import 'Employer/create_profile_emp_screen.dart';
import 'JobSeeker/js_create_profile.dart';
import 'email_login.dart';
import 'email_sign_up.dart';
import 'user_type_select.dart';

class LoginSelectorScreen extends StatefulWidget {
  UserType userType;
  LoginSelectorScreen({required this.userType});

  @override
  State<LoginSelectorScreen> createState() => _LoginSelectorScreenState();
}

String? loggedInUserEmail;
bool isLoading = false;

class _LoginSelectorScreenState extends State<LoginSelectorScreen> {
  @override
  void initState() {
    super.initState();
    isLoading = false;
    getUserDetails();
  }

  getUserDetails() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              Text("JobKart", style: kBigLogoTextStyle),

              SizedBox(height: 16),
              // I am Employer Heading
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      child: Text(
                          widget.userType == UserType.employer
                              ? "I'm Employer"
                              : "I'm JobSeeker",
                          style: kHeading1Style),
                      width: 167,
                      height: 70),
                ),
              ),

              Spacer(),

              // Sign in with Facebook button

              ElevatedButton(
                style: kBigButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(kFacebookBlue)),
                child: Text('Sign In With Facebook'),
                onPressed: () async {
                  //TODO : Implement Facebook Login

                  final fBookSignInProvider =
                  Provider.of<FBookSignInProvider>(context, listen: false);
                  await fBookSignInProvider.fBookLogin();
                  if (fBookSignInProvider.isNewUser ?? false) {
                    //Add user details to database
                    var userData = widget.userType == UserType.employer
                    //During email sign up if the user clicks I'm Employer,
//then the user type is set to employer and the user is created as an employer.
                        ? JKUser(
                      empName:
                      fBookSignInProvider.currentUser!.displayName,
                      email: fBookSignInProvider.currentUser!.email,
                      uid: fBookSignInProvider.firebaseUser!.user!.uid,
                      userType: widget.userType.toString().substring(9),
                    ).toJson()
                        : //creating jobseeker user.
                    JKUser(
                      jsName:
                      fBookSignInProvider.currentUser!.displayName,
                      email: fBookSignInProvider.currentUser!.email,
                      uid: fBookSignInProvider.firebaseUser!.user!.uid,
                      userType: widget.userType.toString().substring(9),
                    ).toJson();

                    String? docIdToUpdate =
                    await UserDBService.saveUserData(userData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        widget.userType == UserType.employer
                            ? EmployerCreateProfileScreen(
                            docIdToUpdate: docIdToUpdate)
                            : JSCreateProfileScreen(
                            docIdToUpdate: docIdToUpdate),
                      ),
                    );
                  } else {
                    navigateToHomeScreen(
                        userCred: fBookSignInProvider.firebaseUser!,
                        context: context);
                  }
                },
              ),

              SizedBox(height: 14),

              // Sign up with email

              ElevatedButton(
                style: kBigButtonStyle,
                child: Text('Sign Up With Email'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EmailSignUpScreen(userType: widget.userType)));
                },
              ),
              Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an Account?", style: kGreyoutHeading4Style),
                  TextButton(
                    child: Text('Sign In',
                        style: kGreyoutHeading4Style.copyWith(
                            color: kBlackColor1)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmailLoginScreen(userType: widget.userType)));
                    },
                  ),
                ],
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
