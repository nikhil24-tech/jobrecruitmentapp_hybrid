import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/screens/user_type_select.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/style.dart';
import '../controllers/login_signup_validators.dart';
import '../models/jk_user.dart';
import '../services/job_kart_db_service.dart';
import 'package:jobrecruitmentapp_hybrid/widgets/motion_toasts.dart';
import 'Employer/create_profile_emp_screen.dart';
import 'JobSeeker/js_create_profile.dart';
import 'email_login.dart';

class EmailSignUpScreen extends StatefulWidget {
  final UserType userType;

  EmailSignUpScreen({required this.userType});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  //TextEditing Controllers for the text input fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  bool isLoading = false;

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
                    // Different value of label based on the user type

                    TextFormField(
                      style: kHeading2RegularStyle,
                      obscureText: true,
                      controller: _passwordController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Password"),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      style: kHeading2RegularStyle,
                      obscureText: true,
                      controller: _passwordConfirmController,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Confirm Password "),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: kBigButtonStyle,
                      child: isLoading == true
                          ? Text('Signing Up...', style: kBigButtonTextStyle)
                          : Text('Sign Up', style: kBigButtonTextStyle),
                      onPressed: isLoading == true
                          ? null
                          : () async {
                        //Once sign up is successful, navigate to create profile screen

                        if (_signUpFormKey.currentState!.validate()) {
                          if (_passwordController.text.trim() ==
                              _passwordConfirmController.text.trim()) {
                            //set the loading to true
                            setState(() {
                              isLoading = true;
                            });

                            String? docID = await createUser();

                            //saving user email to cache
                            final userDataCache =
                            await SharedPreferences.getInstance();
                            await userDataCache.setString(
                                'loggedInUserEmail',
                                _emailController.text.trim());

                            if (docID != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return widget.userType ==
                                        UserType.employer
                                        ? EmployerCreateProfileScreen(
                                        docIdToUpdate: docID,
                                        userEmail:
                                        _emailController.text.trim())
                                        : JSCreateProfileScreen(
                                        docIdToUpdate: docID,
                                        userEmail:
                                        _emailController.text.trim());
                                  }));
                            }
                            //set the loading to false
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            setState(() =>
                            _errorMessage = "Passwords do not match");
                            infoToast(context, _errorMessage,
                                kBigButtonTextStyle);
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
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
//During email sign up if the user clicks I'm Employer,
//then the user type is set to employer and the user is created as an employer.
      var _jkUser = widget.userType == UserType.employer
      //creating employer user
          ? JKUser(
          empName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          userType: widget.userType.toString().substring(9),
          uid: fbCreatedUser.user!.uid)
          .toJson()
      //creating jobseeker user. There is no sign up for admin user.
      // To create admin user sign up as any user and then change
      //the user type to admin in firebase console.
          : JKUser(
          jsName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          userType: widget.userType.toString().substring(9),
          uid: fbCreatedUser.user!.uid)
          .toJson();

      print(_jkUser);
      String? docId = await UserDBService.saveUserData(_jkUser);
      print(docId);
      return docId;
    } on FirebaseAuthException catch (error) {
      setState(() => _errorMessage = error.message!);
      infoToast(context, _errorMessage, kBigButtonTextStyle);
    }
  }
}
