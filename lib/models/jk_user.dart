// write a model class for a user in email_sign_up.dart:
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/style.dart';

class JKUser {
  //Common fields for all users
  String? userType;
  String? email;
  String? uid;
  String? password;
  bool? isBlocked;

  //Employer specific fields
  String? empName;
  String? orgImageUrl;
  String? empPhone;
  String? orgType;
  String? orgName;
  String? orgAddress;
  String? orgLocation;

  //Jobseeker specific fields
  String? jsName;
  String? jsImageUrl;
  String? jsPhone;
  String? jsOccupation;
  String? jsAddress;
  String? jsLocation;
  String? jsEduLevel;
  String? jsJobXp;
  String? jsSkills;
  String? jsAboutMe;

  JKUser({
    //common fields for all users
    required this.userType,
    this.isBlocked = false,
    this.password,
    this.uid,
    //employer specific fields
    this.empName,
    this.email,
    this.orgImageUrl,
    this.empPhone,
    this.orgType,
    this.orgName,
    this.orgAddress,
    this.orgLocation,

    //jobseeker specific fields
    this.jsName,
    this.jsImageUrl,
    this.jsPhone,
    this.jsOccupation,
    this.jsAddress,
    this.jsLocation,
    this.jsEduLevel,
    this.jsJobXp,
    this.jsSkills,
    this.jsAboutMe,
  });

  JKUser.fromDocument(QueryDocumentSnapshot data) {
    //common fields for all users
    userType = data.get('userType');
    email = data.get('email') ?? "Enter email";
    password = data.get('password') ?? "Enter Password";
    uid = data.get('uid') ?? "Enter UID";
    isBlocked = data.get('isBlocked') ?? false;

    //employer specific fields

    empName = data.get('empName') ?? "Enter empName";
    orgImageUrl = data.get('orgImageUrl') ?? kLogoImageUrl;
    empPhone = data.get('empPhone') ?? "Enter Phone";
    orgType = data.get('orgType') ?? "Enter Organisation Type";
    orgName = data.get('orgName') ?? "Enter Organisation Name";
    orgAddress = data.get('orgAddress') ?? "Enter orgLocation ";
    orgLocation = data.get('orgLocation') ?? "Enter orgLocation";

    //jobseeker specific fields
    jsName = data.get('jsName') ?? "Enter Name";
    jsImageUrl = data.get('jsImageUrl') ?? kLogoImageUrl;
    jsPhone = data.get('jsPhone') ?? "Enter Phone";
    jsOccupation = data.get('jsOccupation') ?? "Enter Occupation";
    jsAddress = data.get('jsAddress') ?? "Enter Address";
    jsLocation = data.get('jsLocation') ?? "Enter Location";
    jsEduLevel = data.get('jsEduLevel') ?? "Enter Education Level";
    jsJobXp = data.get('jsJobXp') ?? "Enter Job Experience";
    jsSkills = data.get('jsSkills') ?? "Enter Skills";
    jsAboutMe = data.get('jsAboutMe') ?? "Enter About Me";
  }

  Map<String, dynamic> toJson() {
    return {
      //common fields for all users
      'userType': userType,
      'email': email ?? "Enter Email",
      'password': password ?? "Enter Password",
      'uid': uid ?? "Enter UID",
      'isBlocked': isBlocked ?? false,

      //employer specific fields
      'empName': empName ?? "Enter Name",
      'orgImageUrl': orgImageUrl ?? kLogoImageUrl,
      'empPhone': empPhone ?? "Enter Phone",
      'orgType': orgType ?? "Enter Organisation Type",
      'orgName': orgName ?? "Enter Organisation Name",
      'orgAddress': orgAddress ?? "Enter Organisation Address",
      'orgLocation': orgLocation ?? "Enter Address",

      //jobseeker specific fields
      'jsName': jsName ?? "Enter Name",
      'jsImageUrl': jsImageUrl ?? kLogoImageUrl,
      'jsPhone': jsPhone ?? "Enter Phone",
      'jsOccupation': jsOccupation ?? "Enter Occupation",
      'jsAddress': jsAddress ?? "Enter Address",
      'jsLocation': jsLocation ?? "Enter Location",
      'jsEduLevel': jsEduLevel ?? "Enter Education Level",
      'jsJobXp': jsJobXp ?? "Enter Job Experience",
      'jsSkills': jsSkills ?? "Enter Skills",
      'jsAboutMe': jsAboutMe ?? "Enter About Me",
    };
  }
}
