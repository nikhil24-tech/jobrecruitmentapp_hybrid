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
    jobID = data.get('jobID');
    jobName = data.get('jobName');
    jobLocation = data.get('jobLocation');
    jsName = data.get('jsName');
    jsPhone = data.get('jsPhone');
    jsEmail = data.get('jsEmail');
    jsAddress = data.get('jsAddress');
    jsAboutMe = data.get('jsAboutMe');
    jsSkills = data.get('jsSkills');
    jsExperience = data.get('jsExperience');
    jsImageUrl = data.get('jsImageUrl');
    orgType = data.get('orgType');
    salaryPerHr = data.get('salaryPerHr');
    jobDescription = data.get('jobDescription');
    requirements = data.get('requirements');
    empEmail = data.get('empEmail');
    empPhone = data.get('empPhone');
    orgAddress = data.get('orgAddress');
    isApproved = data.get('isApproved');
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
