import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/screens/user_type_select.dart';
import '../../constants/style.dart';
import '../controllers/login_signup_validators.dart';
import '../models/jk_user.dart';
import '../services/job_kart_db_service.dart';
import 'Employer/create_profile_emp_screen.dart';
import 'email_login.dart';

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
                      style: kHeading2RegularStyle,
                      controller: _nameController,
                      decoration:
                      kTextFieldInputDecoration.copyWith(labelText: "Name"),
                      validator: nameValidator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _emailController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Email"),
                      validator: emailValidator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _phoneController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Phone"),
                      validator: phoneValidator,
                    ),
                    SizedBox(height: 12),
                    // Different value of label based on the user type

                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: widget.userType == UserType.employer
                          ? _organisationController
                          : _occupationController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: (widget.userType == UserType.employer)
                              ? "Organisation Type"
                              : "Occupation"),
                      validator: orgOrOccupationValidator,
                    ),

                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _passwordController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Password"),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _passwordConfirmController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Confirm Password "),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: kBigButtonStyle,
                      child: Text('Sign Up', style: kBigButtonTextStyle),
                      onPressed: () async {
                        //Once sign up is successful, navigate to create profile screen

                        if (_signUpFormKey.currentState!.validate()) {
                          if (_passwordController.text ==
                              _passwordConfirmController.text) {
                            String? docID = await createUser();
                            if (docID != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return widget.userType == UserType.employer
                                        ? EmployerCreateProfileScreen(
                                        docIdToUpdate: docID)
                                        : EmployerCreateProfileScreen(
                                        docIdToUpdate: docID);
                                  }));
                            }
                          } else {
                            setState(
                                    () => _errorMessage = "Passwords do not match");
                            errorToast(
                                context, _errorMessage, kBigButtonTextStyle);
                          }
                        }
                      },
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailLoginScreen(
                                        userType: widget.userType)));
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

  Future<String?> createUser() async {
    try {
      UserCredential fbCreatedUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      var _jkUser = JKUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          userType: widget.userType.toString().substring(9),
          organisationType: widget.userType == UserType.employer
              ? _organisationController.text
              : "No Org",
          occupation: widget.userType == UserType.jobseeker
              ? _occupationController.text
              : "No Occupation",
          uid: fbCreatedUser.user!.uid)
          .toJson();
      print(_jkUser);
      String? docId = await UserDBService.saveUserData(_jkUser);
      print(docId);
      return docId;
    } on FirebaseAuthException catch (error) {
      setState(() => _errorMessage = error.message!);
      errorToast(context, _errorMessage, kBigButtonTextStyle);
    }
  }
}
