import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/style.dart';
import 'user_type_select.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              ElevatedButton(
                style: kBigButtonStyle,
                child: Text('Get Started'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserTypeSelectScreen()));
                },
              ),
              SizedBox(height: 28)
            ],
          ),
        ),
      ),
    );
  }
}
