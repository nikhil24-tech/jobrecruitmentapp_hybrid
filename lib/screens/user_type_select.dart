import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/style.dart';
import 'login_selector_screen.dart';
import 'email_login.dart';

enum UserType { employer, jobseeker, admin }

class UserTypeSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text("JobKart", style: kBigLogoTextStyle),
            Spacer(flex: 4),
            Text(
              "Create Job search Advert",
              style: TextStyle(
                color: kTextFontColor1,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Step by step instructions to create a job search website on your own in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kThemeColor1,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: GoogleFonts.inter().fontFamily,
                ),
              ),
            ),
            Spacer(flex: 3),
            //Admin Button
            ElevatedButton(
              style: kBigButtonStyle,
              child: Text('Admin'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmailLoginScreen(
                          userType: UserType.admin,
                        )));
              },
            ),
            SizedBox(height: 14),
            // Employer Selection Button
            ElevatedButton(
              style: kBigButtonStyle,
              child: Text('I\'m Employer'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginSelectorScreen(
                          userType: UserType.employer,
                        )));
              },
            ),
            SizedBox(height: 14),
            // Job Seeker Selection Button
            ElevatedButton(
              style: kBigButtonStyle,
              child: Text('I\'m Job Seeker'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginSelectorScreen(
                          userType: UserType.jobseeker,
                        )));
              },
            ),
            SizedBox(height: 28)
          ],
        ),
      ),
    );
  }
}
