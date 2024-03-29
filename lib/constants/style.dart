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

const String kLogoImageUrl =
    "https://firebasestorage.googleapis.com/v0/b/jobkart-46567.appspot.com/o/userProfileImages%2FJobKartLogo.png?alt=media&token=8164c65f-210b-410a-a6cc-1cd4b52770bd";

const String kLoadingAnimationGif =
    "https://dltqhkoxgn1gx.cloudfront.net/img/posts/6-vue-loader-animation-libraries-to-reduce-your-bounce-rate-2.png";

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
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kHeading2BoldStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: kThemeColor1,
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kHeading2RegularStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(78, 77, 77, 1),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kHeading3DarkStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF112E6F),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kHeading3RegularStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(130, 129, 129, 1),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kHeading3DarkBoldStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color(0xFF554F4F),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kAppTextBoldWhiteStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFFFDFDFD),
    fontFamily: GoogleFonts.inter().fontFamily);

TextStyle kAppTextDarkBoldStyle =
kAppTextBoldWhiteStyle.copyWith(color: Color(0xFF112E6F));

TextStyle kAppRegularTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
    fontFamily: GoogleFonts.inter().fontFamily);

EdgeInsets kBigButttonPadding =
EdgeInsets.symmetric(vertical: 18, horizontal: 106);

TextStyle kBigButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  fontFamily: GoogleFonts.inter().fontFamily,
);

TextStyle kSmallButtonTextStyle = TextStyle(
  color: Color(0xFFE5EBFA),
  fontWeight: FontWeight.w700,
  fontSize: 14,
  fontFamily: GoogleFonts.inter().fontFamily,
);

TextStyle kGreyoutHeading3Style = TextStyle(
  color: Color(0xFF858688),
  fontSize: 22,
  fontWeight: FontWeight.w700,
  fontFamily: GoogleFonts.inter().fontFamily,
);

TextStyle kGreyoutHeading4Style = TextStyle(
  color: Color(0xFF828181),
  fontSize: 20,
  fontWeight: FontWeight.w400,
  fontFamily: GoogleFonts.inter().fontFamily,
);

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

InputDecoration kTextFieldInputDecorationMultiLine = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  fillColor: kTextFieldColor,
  hintMaxLines: 6,
  filled: true,
  labelText: 'Provide hint text here',
  labelStyle:
  kGreyoutHeading4Style.copyWith(fontSize: 14, color: Color(0xFF6D6565)),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);

imageSet({Image? imageFile}) {
  return ClipOval(
    child: imageFile == null
        ? SizedBox(
        height: 100,
        width: 100,
        child: CircleAvatar(backgroundColor: Color(0xFFD9D9D9)))
        : SizedBox(
      height: 100,
      width: 100,
      // Some images are not cicrular, so we need to make them round.
      child: CircleAvatar(
        child: FadeInImage(
          placeholder: Image.network(kLoadingAnimationGif).image,
          image: imageFile.image,
        ),
      ),
    ),
  );
}
