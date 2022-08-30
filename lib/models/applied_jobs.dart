import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedJob {
  String? jobID;
  String? jobName;
  String? jobLocation;
  String? orgType;
  String? salaryPerHr;
  String? jobDescription;
  String? requirements;
  String? empEmail;
  String? empPhone;
  String? orgAddress;
  String? jsName;
  String? jsPhone;
  String? jsEmail;
  String? jsAddress;
  String? jsAboutMe;
  String? jsSkills;
  String? jsExperience;
  String? jsImageUrl;
  bool? isApproved;

  AppliedJob(
      {this.jobID,
        this.jsName,
        this.jobName,
        this.jobLocation,
        this.jsPhone,
        this.jsEmail,
        this.jsAddress,
        this.jsAboutMe,
        this.jsSkills,
        this.jsExperience,
        this.jsImageUrl,
        this.orgType,
        this.salaryPerHr,
        this.jobDescription,
        this.requirements,
        this.empEmail,
        this.empPhone,
        this.orgAddress,
        this.isApproved});

  AppliedJob.fromDocument(QueryDocumentSnapshot data) {
    Map m = data.data() as Map;
    jobID = m['jobID'] ?? "";
    jobName = m['jobName'] ?? "";
    jobLocation = m['jobLocation'] ?? "";
    jsName = m['jsName'] ?? "";
    jsPhone = m['jsPhone'] ?? "";
    jsEmail = m['jsEmail'] ?? "";
    jsAddress = m['jsAddress'] ?? "";
    jsAboutMe = m['jsAboutMe'] ?? "";
    jsSkills = m['jsSkills'] ?? "";
    jsExperience = m['jsExperience'] ?? "";
    jsImageUrl = m['jsImageUrl'] ?? "";
    orgType = m['orgType'] ?? "";
    salaryPerHr = m['salaryPerHr'] ?? "";
    jobDescription = m['jobDescription'] ?? "";
    requirements = m['requirements'] ?? "";
    empEmail = m['empEmail'] ?? "";
    empPhone = m['empPhone'] ?? "";
    orgAddress = m['orgAddress'] ?? "";
    isApproved = m['isApproved'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'jobID': jobID,
      'jobName': jobName,
      'jobLocation': jobLocation,
      'jsName': jsName,
      'jsPhone': jsPhone,
      'jsEmail': jsEmail,
      'jsAddress': jsAddress,
      'jsAboutMe': jsAboutMe,
      'jsSkills': jsSkills,
      'jsExperience': jsExperience,
      'jsImageUrl': jsImageUrl,
      'orgType': orgType,
      'salaryPerHr': salaryPerHr,
      'jobDescription': jobDescription,
      'requirements': requirements,
      'empEmail': empEmail,
      'empPhone': empPhone,
      'orgAddress': orgAddress,
      'isApproved': isApproved,
    };
  }
}
