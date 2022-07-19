import 'package:cloud_firestore/cloud_firestore.dart';

class JobProfile {
  String? jobID;
  String? jobName;
  String? orgAddress;
  String? location;
  String? orgContactEmail;
  String? phone;
  String? orgType;
  String? salary;
  String? jobDescription;
  String? requirements;
  String? employerImageUrl;
  List? 
      jsSavedAndApplied; // A list of users who have saved or applied for this job.

  JobProfile({
    this.jobID,
    this.jobName,
    this.orgAddress,
    this.location,
    this.orgContactEmail,
    this.phone,
    this.orgType,
    this.salary,
    this.jobDescription,
    this.requirements,
    this.employerImageUrl,
     this.jsSavedAndApplied,
  });

//address = data.get('address');

  JobProfile.fromDocument(QueryDocumentSnapshot data) {
    jobID = data.id; // getting the doc id of the document from firestore
    jobName = data.get('jobName');
    orgAddress = data.get('orgAddress');
    location = data.get('location');
    orgContactEmail = data.get('orgContactEmail');
    phone = data.get('phone');
    orgType = data.get('orgType');
    salary = data.get('salary');
    jobDescription = data.get('jobDescription');
    requirements = data.get('requirements');
    jsSavedAndApplied = data.get('jsSavedAndApplied') ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      //Here we are sending the data to firestore as map to create a document
      //hence we don't have doc id as the document is not created yet and
      //we don't have to send the doc id as the document is not created yet

      'jobName': jobName,
      'orgAddress': orgAddress,
      'location': location,
      'orgContactEmail': orgContactEmail,
      'phone': phone,
      'orgType': orgType,
      'salary': salary,
      'jobDescription': jobDescription,
      'requirements': requirements,
      'jsSavedAndApplied': jsSavedAndApplied ?? [],
    };
  }
}
