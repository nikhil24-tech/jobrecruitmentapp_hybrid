import 'package:cloud_firestore/cloud_firestore.dart';

class JobProfile {
  String? jobID;
  String? jobName;
  String? orgName;
  String? orgType;
  String? jobLocation;
  String? jobAddress;
  String? salaryPerHr;
  String? jobDescription;
  String? jobRequirements;
  String? empEmail;
  String? empPhone;
  String? orgImageUrl;
  List?
  jsSavedAndApplied; // A list of users who have saved or applied for this job.

  JobProfile({
    this.jobID,
    this.jobName,
    this.orgName,
    this.orgType,
    this.jobLocation,
    this.jobAddress,
    this.salaryPerHr,
    this.jobDescription,
    this.jobRequirements,
    this.empEmail,
    this.empPhone,
    this.orgImageUrl,
    this.jsSavedAndApplied,
  });

//address = data.get('address');

  JobProfile.fromDocument(QueryDocumentSnapshot data) {
    jobID = data.id; // getting the doc id of the document from firestore
    jobName = data.get('jobName') ?? 'jobName';
    orgName = data.get('orgName') ?? 'orgName';
    orgType = data.get('orgType') ?? 'orgType';
    jobLocation = data.get('jobLocation') ?? 'jobLocation';
    jobAddress = data.get('jobAddress') ?? 'jobAddress';
    salaryPerHr = data.get('salaryPerHr') ?? 'salaryPerHr';
    jobDescription = data.get('jobDescription') ?? 'jobDescription';
    jobRequirements = data.get('jobRequirements') ?? 'jobRequirements';
    empEmail = data.get('empEmail') ?? 'empEmail';
    empPhone = data.get('empPhone') ?? 'empPhone';
    orgImageUrl = data.get('orgImageUrl') ?? 'orgImageUrl';
    jsSavedAndApplied = data.get('jsSavedAndApplied') ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      //Here we are sending the data to firestore as map to create a document
      //hence we don't have doc id as the document is not created yet and
      //we don't have to send the doc id as the document is not created yet
      'jobName': jobName ?? 'jobName',
      'orgName': orgName ?? 'orgName',
      'orgType': orgType ?? 'orgType',
      'jobLocation': jobLocation ?? 'jobLocation',
      'jobAddress': jobAddress ?? 'jobAddress',
      'salaryPerHr': salaryPerHr ?? 'salaryPerHr',
      'jobDescription': jobDescription ?? 'jobDescription',
      'jobRequirements': jobRequirements ?? 'jobRequirements',
      'empEmail': empEmail ?? 'empEmail',
      'empPhone': empPhone ?? 'empPhone',
      'orgImageUrl': orgImageUrl ?? 'orgImageUrl',
      'jsSavedAndApplied': jsSavedAndApplied ?? [],
    };
  }
}
