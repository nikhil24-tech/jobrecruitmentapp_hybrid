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

TextStyle kSmallLogoTextStyle = TextStyle(
    color: kThemeColor1,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.jockeyOne().fontFamily);

TextStyle kHeading1Style = TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.w700,
    color: kThemeColor1,
    fontFamily: GoogleFonts.inter().fontFamily);  //TextStyle

TextStyle kHeading2BoldStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: kThemeColor1,
    fontFamily: GoogleFonts.inter().fontFamily);  //TextStyle

TextStyle kHeading3DarkStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF112E6F),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kGreyoutHeading4Style = TextStyle(
  color: Color(0xFF828181),
  fontSize: 20,
  fontWeight: FontWeight.w400,
  fontFamily: GoogleFonts.inter().fontFamily,
);

TextStyle kAppTextBoldWhiteStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFFFDFDFD),
    fontFamily: GoogleFonts.inter().fontFamily);

InputDecoration kTextFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  fillColor: kTextFieldColor,
  filled: true,
  labelText: 'Provide hint text here',
  labelStyle: kGreyoutHeading4Style,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);


EdgeInsets kBigButttonPadding =
EdgeInsets.symmetric(vertical: 18, horizontal: 106);

TextStyle kBigButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  fontFamily: GoogleFonts.inter().fontFamily,
);  //TextStyle

TextStyle kSmallButtonTextStyle = TextStyle(
  color: Color(0xFFE5EBFA),
  fontWeight: FontWeight.w700,
  fontSize: 14,
  fontFamily: GoogleFonts.inter().fontFamily,
);


TextStyle kAppTextDarkBoldStyle =
kAppTextBoldWhiteStyle.copyWith(color: Color(0xFF112E6F));

OutlinedBorder kBigButtonShape =
RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

ButtonStyle kBigButtonStyle = ElevatedButton.styleFrom(
    shape: kBigButtonShape,
    fixedSize: Size(354, 55),
    textStyle: kBigButtonTextStyle,
    primary: kThemeColor1);

ButtonStyle kSmallButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
    fixedSize: Size(138, 39),
    textStyle: kSmallButtonTextStyle,
    primary: kThemeColor1);

