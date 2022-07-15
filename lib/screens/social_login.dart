import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/constants/style.dart';
import 'email_login.dart';
import 'email_signup.dart';
import 'user_type_select.dart';

class SocialLoginScreen extends StatelessWidget {
  UserType userType;
  SocialLoginScreen({required this.userType});
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
                          userType == UserType.employer
                              ? "I'm Employer"
                              : "I'm JobSeeker",
                          style: kHeading1Style),
                      width: 167,
                      height: 70),
                ),
              ),

              Spacer(),

              SizedBox(height: 14),
              // Sign in with Facebook button

              ElevatedButton(
                style: kBigButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(kFacebookBlue)),
                child: Text('Sign In With Facebook'),
                onPressed: () {
                  //TODO : Implement Facebook Login
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
                              EmailSignUpScreen(userType: userType)));
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
                                  EmailLoginScreen(userType: userType)));
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
