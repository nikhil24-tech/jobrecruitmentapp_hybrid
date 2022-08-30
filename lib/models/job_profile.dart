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
  String? applicantEmail;
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
    this.applicantEmail,
  });

//address = data.get('address');

  JobProfile.fromDocument(QueryDocumentSnapshot data) {
    jobID = data.id; // getting the doc id of the document from firestore
    jobName = data.data().toString().contains('jobName')
        ? data.get('jobName') ?? 'jobName'
        : 'jobName';
    orgName = data.data().toString().contains('orgName')
        ? data.get('orgName') ?? 'orgName'
        : 'orgName';
    applicantEmail = data.data().toString().contains('applicant_selected')
        ? data.get('applicant_selected') ?? ''
        : '';
    orgType = data.data().toString().contains('orgType')
        ? data.get('orgType') ?? 'orgType'
        : 'orgType';
    jobLocation = data.data().toString().contains('jobLocation')
        ? data.get('jobLocation') ?? 'jobLocation'
        : 'jobLocation';
    jobAddress = data.data().toString().contains('jobAddress')
        ? data.get('jobAddress') ?? 'jobAddress'
        : 'jobAddress';
    salaryPerHr = data.data().toString().contains('salaryPerHr')
        ? data.get('salaryPerHr') ?? 'salaryPerHr'
        : 'salaryPerHr';
    jobDescription = data.data().toString().contains('jobDescription')
        ? data.get('jobDescription') ?? 'jobDescription'
        : 'jobDescription';
    jobRequirements = data.data().toString().contains('jobRequirements')
        ? data.get('jobRequirements') ?? 'jobRequirements'
        : 'jobRequirements';
    empEmail = data.data().toString().contains('empEmail')
        ? data.get('empEmail') ?? 'empEmail'
        : 'empEmail';
    empPhone = data.data().toString().contains('empPhone')
        ? data.get('empPhone') ?? 'empPhone'
        : 'empPhone';
    orgImageUrl = data.data().toString().contains('orgImageUrl')
        ? data.get('orgImageUrl') ?? 'orgImageUrl'
        : 'orgImageUrl';
    jsSavedAndApplied = data.data().toString().contains('jsSavedAndApplied')
        ? ((data.get('jsSavedAndApplied')) ?? [])
        : [];
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
