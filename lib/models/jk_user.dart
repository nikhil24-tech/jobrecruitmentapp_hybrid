// write a model class for a user in email_sign_up.dart:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobrecruitmentapp_hybrid/constants/style.dart';

class JKUser {
  String? address;
  String? email;
  String? imageUrl;
  String? name;
  String? occupation;
  String? orgName;
  String? organisationType;
  String? password;
  String? phone;
  String? uid;
  String? userType;
  String? aboutMe;
  String? educationLevel;
  String? jobExperience;
  String? skills;

  JKUser(
      {required this.userType,
      this.name,
      this.email,
      this.phone,
      this.occupation,
      this.organisationType,
      this.password,
      this.uid,
      this.orgName,
      this.address,
      this.imageUrl,
      this.aboutMe,
      this.educationLevel,
      this.jobExperience,
      this.skills});

  JKUser.fromDocument(QueryDocumentSnapshot data) {
    userType = data.get('userType');
    name = data.get('name') ?? "Enter Name";
    email = data.get('email') ?? "Enter Email";
    phone = data.get('phone') ?? "Enter Phone";
    occupation = data.get('occupation') ?? "Enter Occupation";
    organisationType =
        data.get('organisationType') ?? "Enter Organisation Type";
    password = data.get('password') ?? "Enter Password";
    uid = data.get('uid') ?? "Enter UID";
    orgName = data.get('orgName') ?? "Enter Organisation Name";
    address = data.get('address') ?? "Enter Address";
    imageUrl = data.get('imageUrl') ?? kLogoImageUrl;
    aboutMe = data.get('aboutMe') ?? "Enter About Me";
    educationLevel = data.get('educationLevel') ?? "Enter Education Level";
    jobExperience = data.get('jobExperience') ?? "Enter Job Experience";
    skills = data.get('skills') ?? "Enter Skills";
  }

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'name': name ?? "Enter Name",
      'email': email ?? "Enter Email",
      'phone': phone ?? "Enter Phone",
      'occupation': occupation ?? "Enter Occupation",
      'organisationType': organisationType ?? "Enter Organisation Type",
      'password': password ?? "Enter Password",
      'uid': uid ?? "Enter UID",
      'orgName': orgName ?? "Enter Organisation Name",
      'address': address ?? "Enter Address",
      'imageUrl': imageUrl ?? kLogoImageUrl,
      'aboutMe': aboutMe ?? "Enter About Me",
      'educationLevel': educationLevel ?? "Enter Education Level",
      'jobExperience': jobExperience ?? "Enter Job Experience",
      'skills': skills ?? "Enter Skills",
    };
  }
}
