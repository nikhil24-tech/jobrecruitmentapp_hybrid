import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/style.dart';
import '../models/jk_user.dart';
import '../models/job_profile.dart';


// Jobs Collection and helper methods

class JobsDBService {
  static final CollectionReference jobCollectionReferece =
  FirebaseFirestore.instance.collection('jobs');

  static Future<String?> saveJobData(jobData) async {
    //write a function to save JKUser model class data to firestore
    try {
      var docID = await jobCollectionReferece.add(jobData);
      return docID.id;
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }
  //write a function to search for jobs based on the search keywords

  static Future<List<JobProfile>?> searchJobs(String searchKeyword) async {
    //write a function to search for jobs based on the search keywords
    try {
      QuerySnapshot querySnapshot = await jobCollectionReferece
          .where('jobName', isGreaterThanOrEqualTo: searchKeyword)
          .get();
      List<JobProfile> jobs = querySnapshot.docs.map((doc) {
        return JobProfile.fromDocument(doc);
      }).toList();
      return jobs;
    } on FirebaseException catch (error) {
      print(error.message);
      return null;
    }
  }

  //write a function to delete a job listing from firestore
  static Future<void> deleteJobPosting({required String jobID}) async {
    try {
      await jobCollectionReferece.doc(jobID).delete();
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to update a job listing in firestore based on doc id
  static Future<void> updateJobData(
      {required String docIdToUpdate, required jobData}) async {
    try {
      await jobCollectionReferece.doc(docIdToUpdate).update(jobData);
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to get all jobs data from firestore
  static Future<List<JobProfile>?> getAllJobsData() async {
    //get all jobs  data from firestore
    try {
      QuerySnapshot querySnapshot = await jobCollectionReferece.get();
      List<JobProfile> jobs = querySnapshot.docs.map((doc) {
        return JobProfile.fromDocument(doc);
      }).toList();
      return jobs;
    } on FirebaseException catch (error) {
      print(error.message);
      return null;
    }
  }

  //write a function to update a doc and append to jsSavedAndApplied list field

  static Future<void> jsSaveJob({required JobProfile jobProfile}) async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    final userEmail = userDataCache.getString("loggedInUserEmail")!;

    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayUnion([
        {"jsEmail": userEmail, "isSaved": true, "isApplied": false}
      ])
    });

    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayRemove([
        {"jsEmail": userEmail, "isSaved": false, "isApplied": false}
      ])
    });
  }

  // write a function to change the isSaved field to false to unsave job

  static Future<void> jsUnSaveJob({required JobProfile jobProfile}) async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    final userEmail = userDataCache.getString("loggedInUserEmail")!;

    //get the doc id of the job profile
    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayRemove([
        {"jsEmail": userEmail, "isSaved": true, "isApplied": false}
      ])
    });

    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayUnion([
        {"jsEmail": userEmail, "isSaved": false, "isApplied": false}
      ])
    });
  }

// write a function to change the isSaved field to false to unsave job

  static Future<void> jsApplyUnsavedJob(
      {required JobProfile jobProfile}) async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    final userEmail = userDataCache.getString("loggedInUserEmail")!;

    //get the doc id of the job profile
    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayRemove([
        {"jsEmail": userEmail, "isSaved": false, "isApplied": false}
      ])
    });

    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayUnion([
        {"jsEmail": userEmail, "isSaved": false, "isApplied": true}
      ])
    });
  }

  static Future<void> jsApplySavedJob({required JobProfile jobProfile}) async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    final userEmail = userDataCache.getString("loggedInUserEmail")!;

    //get the doc id of the job profile
    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayRemove([
        {"jsEmail": userEmail, "isSaved": true, "isApplied": false}
      ])
    });

    await jobCollectionReferece.doc(jobProfile.jobID).update({
      'jsSavedAndApplied': FieldValue.arrayUnion([
        {"jsEmail": userEmail, "isSaved": false, "isApplied": true}
      ])
    });
  }
}

//Applied Jobs Collection and helper methods

class AppliedJobsDBService {
  static final CollectionReference appliedJobCollectionReferece =
  FirebaseFirestore.instance.collection('appliedJobs');

  static Future<void> saveAppliedJobData({required appliedJobData}) async {
    //write a function to save JKUser model class data to firestore
    try {
      await appliedJobCollectionReferece.add(appliedJobData);
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to update isApproved field to true in firestore based on jobID

  static Future<void> approveJob({required String jobID}) async {
    try {
      await appliedJobCollectionReferece
          .doc(jobID)
          .update({'isApproved': true});
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to update isApproved field to false in firestore based on jobID

  static Future<void> rejectJob({required String jobID}) async {
    try {
      await appliedJobCollectionReferece
          .doc(jobID)
          .update({'isApproved': false});
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to delete all documents in appliedJobCollectionReferece where jobID is equal to jobID
  static Future<void> deleteAppliedJobByJobID({required String jobID}) async {
    try {
      var docsToBeDeleted = await appliedJobCollectionReferece
          .where('jobID', isEqualTo: jobID)
          .get();

      for (var doc in docsToBeDeleted.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }
}

// Users Collection and helper methods
class UserDBService {
  static final CollectionReference userCollectionReferece =
  FirebaseFirestore.instance.collection('jk_users');

  static Future<String?> saveUserData(userData) async {
    //write a function to save JKUser model class data to firestore
    try {
      var docID = await userCollectionReferece.add(userData);
      return docID.id;
    } on FirebaseException catch (error) {
      print(error.message);
      return null;
    }
  }

  //write a function to get userType from userCollectionReferece based on uid
  static Future<String?> getUserTypeByEmail({required String email}) async {
    try {
      var userTypeDoc =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      String? userType = userTypeDoc.docs[0].get("userType");

      return userType;
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  static Future<String?> uploadUserDPToFirebase(
      {required File? imageFile}) async {
    if (imageFile != null) {
      try {
        final fileName = imageFile.path.split('/').last;
        final path = "userProfileImages/$fileName";

        final storageRef = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = storageRef.putFile(imageFile);
        final snapshot = await uploadTask.whenComplete(() => null);

        final imageUrl = await snapshot.ref.getDownloadURL();
        print("Download link is $imageUrl");
        return imageUrl;
      } on FirebaseException catch (error) {
        print(error.message);
      }
    } else {
      return null;
    }
  }

  //write a function to update user data in userCollectionReferece based on uid
  static Future<void> updateUserDataByDocID(
      {required String? updateDocId, required userData}) async {
    try {
      await userCollectionReferece.doc(updateDocId).update(userData);
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  static Future<void> updateUserDataByEmail(
      {required String? email, required userData}) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      //update user data in userCollectionReferece based on email
      await userCollectionReferece
          .doc(userTypeDocQuerySnapshot.docs[0].id)
          .update(userData);
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  static Future<JKUser> getEmployerProfile({required String email}) async {
    var userTypeDocQuerySnapshot =
    await userCollectionReferece.where("email", isEqualTo: email).get();
    var userTypeDoc = userTypeDocQuerySnapshot.docs[0];
    var employerProfile = JKUser.fromDocument(userTypeDoc);
    return employerProfile;
  }

  static Future<JKUser> getJobSeekerProfile({required String email}) async {
    var userTypeDocQuerySnapshot =
    await userCollectionReferece.where("email", isEqualTo: email).get();
    var userTypeDoc = userTypeDocQuerySnapshot.docs[0];
    var jobSeekerProfile = JKUser.fromDocument(userTypeDoc);
    return jobSeekerProfile;
  }

  static Future<JKUser> getJKProfile({required String email}) async {
    var userTypeDocQuerySnapshot =
    await userCollectionReferece.where("email", isEqualTo: email).get();
    var userTypeDoc = userTypeDocQuerySnapshot.docs[0];
    var jKUser = JKUser.fromDocument(userTypeDoc);
    return jKUser;
  }

//write a function to get orgImageUrl from userCollectionReferece based on email
  static Future<String?> getOrgImageUrl(String email) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      String? imageUrl = userTypeDocQuerySnapshot.docs[0].get("orgImageUrl");
      return imageUrl;
    } on FirebaseException catch (error) {
      print(error.message);
      return kLogoImageUrl;
    }
  }

  //write a function to get jsImageUrl from userCollectionReferece based on email
  static Future<String?> getJSImageUrl(String email) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      String? imageUrl = userTypeDocQuerySnapshot.docs[0].get("jsImageUrl");
      return imageUrl;
    } on FirebaseException catch (error) {
      print(error.message);
      return kLogoImageUrl;
    }
  }

  //write a function to update the field isBlocked to true base on email

  static Future<void> blockUser({required String email}) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      await userCollectionReferece
          .doc(userTypeDocQuerySnapshot.docs[0].id)
          .update({"isBlocked": true});
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to update the field isBlocked to false base on email

  static Future<void> UnBlockUser({required String email}) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      await userCollectionReferece
          .doc(userTypeDocQuerySnapshot.docs[0].id)
          .update({"isBlocked": false});
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }

  //write a function to get the field isBlocked based on email
  static Future<bool?> getIsBlocked({required String email}) async {
    try {
      var userTypeDocQuerySnapshot =
      await userCollectionReferece.where("email", isEqualTo: email).get();
      if (userTypeDocQuerySnapshot.docs == [] ||
          userTypeDocQuerySnapshot.docs.isEmpty) {
        return null;
      } else {
        bool isBlocked = userTypeDocQuerySnapshot.docs[0].get("isBlocked");
        return isBlocked;
      }
    } on FirebaseException catch (error) {
      print(error.message);
      return null;
    }
  }
}
