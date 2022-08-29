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

  JKUser.fromDocument(QueryDocumentSnapshot d) {
    Map data = d.data() as Map;
    //common fields for all users
    userType = data['userType'];
    email = data['email'] ?? "Enter email";
    password = data['password'] ?? "Enter Password";
    uid = data['uid'] ?? "Enter UID";
    isBlocked = data['isBlocked'] ?? false;

    //employer specific fields

    empName = data['empName'] ?? "Enter empName";
    orgImageUrl = data['orgImageUrl'] ?? kLogoImageUrl;
    empPhone = data['empPhone'] ?? "Enter Phone";
    orgType = data['orgType'] ?? "Enter Organisation Type";
    orgName = data['orgName'] ?? "Enter Organisation Name";
    orgAddress = data['orgAddress'] ?? "Enter orgLocation ";
    orgLocation = data['orgLocation'] ?? "Enter orgLocation";

    //jobseeker specific fields
    jsName = data['jsName'] ?? "Enter Name";
    jsImageUrl = data['jsImageUrl'] ?? kLogoImageUrl;
    jsPhone = data['jsPhone'] ?? "Enter Phone";
    jsOccupation = data['jsOccupation'] ?? "Enter Occupation";
    jsAddress = data['jsAddress'] ?? "Enter Address";
    jsLocation = data['jsLocation'] ?? "Enter Location";
    jsEduLevel = data['jsEduLevel'] ?? "Enter Education Level";
    jsJobXp = data['jsJobXp'] ?? "Enter Job Experience";
    jsSkills = data['jsSkills'] ?? "Enter Skills";
    jsAboutMe = data['jsAboutMe'] ?? "Enter About Me";
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
