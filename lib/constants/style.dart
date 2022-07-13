import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kThemeColor1 = const Color(0xFF0351FF);
Color kBackgroundColor = const Color(0xFFFFFFFF);
Color kTextFontColor1 = const Color(0xFF212F80);
Color kGoogleRed = const Color(0xFFDB4437);
Color kFacebookBlue = const Color(0xFF4267B2);
Color kTextFieldColor = const Color(0xFFF6F2F2);
Color kBlackColor1 = const Color(0xFF040404);
Color kDeleteRedColor = const Color(0xFFFF0303);
Color kContainerBackgroundColor = const Color.fromRGBO(226, 225, 225, 0.46);

TextStyle kBigLogoTextStyle = TextStyle(
    color: kThemeColor1,
    fontSize: 80,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.jockeyOne().fontFamily);



EdgeInsets kBigButttonPadding =
EdgeInsets.symmetric(vertical: 18, horizontal: 106);

TextStyle kBigButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  fontFamily: GoogleFonts.inter().fontFamily,
);


OutlinedBorder kBigButtonShape =
RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

ButtonStyle kBigButtonStyle = ElevatedButton.styleFrom(
    shape: kBigButtonShape,
    fixedSize: Size(354, 55),
    textStyle: kBigButtonTextStyle,
    primary: kThemeColor1);

