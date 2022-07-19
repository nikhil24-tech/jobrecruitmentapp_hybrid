import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/screens/user_type_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/style.dart';
import '../controllers/login_signup_validators.dart';
import '../controllers/navigate_to_home_screen.dart';
import 'email_signup.dart';

class EmailLoginScreen extends StatefulWidget {
  final UserType userType;
  EmailLoginScreen({required this.userType});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  String _errorMessage = '';

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 41),
                    Text('JobKart', style: kBigLogoTextStyle),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        //(foo==1)? something1():(foo==2)? something2(): something3();
                          child: Text(
                              (widget.userType == UserType.employer)
                                  ? "I'm Employer"
                                  : (widget.userType == UserType.jobseeker)
                                  ? "I'm JobSeeker"
                                  : "Admin",
                              style: kHeading1Style),
                          width: 167,
                          height: 70),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _emailTextController,
                      decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Email",
                      ),
                      validator: emailValidator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _passwordController,
                      decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Password",
                      ),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: kBigButtonStyle,
                      child: Text('Sign In', style: kBigButtonTextStyle),
                      onPressed: () async {
                        //TODO:Implement Sign In Logic

                        if (_signInFormKey.currentState!.validate()) {
                          try {
                            UserCredential _userCred = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                email: _emailTextController.text.trim(),
                                password: _passwordController.text.trim());

                            //saving user email to cache
                            final userDataCache =
                            await SharedPreferences.getInstance();
                            await userDataCache.setString('loggedInUserEmail',
                                _emailTextController.text.trim());

                            await navigateToHomeScreen(
                                userCred: _userCred, context: context);
                          } on FirebaseAuthException catch (error) {
                            setState(() => _errorMessage = error.message!);
                            errorToast(
                                context,
                                _errorMessage,
                                kSmallButtonTextStyle.copyWith(
                                    color: Colors.white, fontSize: 16));
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    widget.userType == UserType.admin
                        ? Text("")
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account?",
                            style: kGreyoutHeading4Style),
                        TextButton(
                            child: Text('Sign Up',
                                style: kGreyoutHeading4Style.copyWith(
                                    color: kBlackColor1)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSignUpScreen(
                                      userType: widget.userType),
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
