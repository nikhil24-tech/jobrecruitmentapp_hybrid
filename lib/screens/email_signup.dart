
import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/screens/user_type_select.dart';

import '../constants/style.dart';
import 'Employer/home_screen_employer.dart';
import 'JobSeeker/home_screen_jobseeker.dart';

class EmailSignUpScreen extends StatefulWidget {
  UserType userType;

  EmailSignUpScreen({required this.userType});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  //TextEditing Controllers for the text input fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _organisationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  String _errorMessage = '';

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
                key: _signUpFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('JobKart', style: kBigLogoTextStyle),
                    SizedBox(height: 12),
                    Align(
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
                    SizedBox(height: 25),

                    //Text Fields for the user to enter their details

                    TextFormField(
                      controller: _nameController,
                      decoration:
                      kTextFieldInputDecoration.copyWith(labelText: "Name"),

                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Email"),

                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Phone"),

                    ),
                    SizedBox(height: 12),
                    // Different value of label based on the user type

                    TextFormField(
                      controller: widget.userType == UserType.employer
                          ? _organisationController
                          : _occupationController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: (widget.userType == UserType.employer)
                              ? "Organisation Type"
                              : "Occupation"),
                    ),

                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Password"),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordConfirmController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Confirm Password "),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        style: kBigButtonStyle,
                        child: Text('Sign Up', style: kBigButtonTextStyle),
                        onPressed: (){
                          widget.userType == UserType.employer
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  EmployerHomeScreen()),
                          ) : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>JobSeekerHomeScreen()),
                          );

                        }
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an Account?", style: kGreyoutHeading4Style),
                        TextButton(
                          child: Text('Sign In',
                              style: kGreyoutHeading4Style.copyWith(
                                  color: kBlackColor1)),
                          onPressed: () {

                          },
                        ),
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