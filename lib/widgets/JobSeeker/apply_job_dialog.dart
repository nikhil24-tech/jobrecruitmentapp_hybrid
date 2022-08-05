import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../controllers/JKUser_data_controller.dart';
import '../../models/applied_jobs.dart';
import '../../models/jk_user.dart';
import '../../models/job_profile.dart';
import '../../services/job_kart_db_service.dart';

Future<dynamic> showApplyJobDialog(
    {required BuildContext context,
    required JobProfile savedJob,
    required String userEmail,
    required bool isJobSaved}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Text("Apply Job With Existing Profile and Resume"),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: kSmallButtonStyle,
                    child: Text("Update Profile"),
                    onPressed: () async {
                      JKUser? jsDetails =
                          await JKUserDataController().getJKUserData();
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: kSmallButtonStyle,
                    child: Text("Apply Job"),
                    onPressed: () async {
                      //Getting User Profile from DB
                      JKUser jsProfile =
                          await UserDBService.getJKProfile(email: userEmail);

                      //Creating AppliedJob Object
                      AppliedJob appliedJob = AppliedJob(
                        jobID: savedJob.jobID,
                        jobName: savedJob.jobName,
                        orgType: savedJob.orgType,
                        jobLocation: savedJob.jobLocation,
                        salaryPerHr: savedJob.salaryPerHr,
                        jobDescription: savedJob.jobDescription,
                        requirements: savedJob.jobRequirements,
                        empEmail: savedJob.empEmail,
                        empPhone: savedJob.empPhone,
                        orgAddress: savedJob.jobAddress,
                        jsName: jsProfile.jsName,
                        jsPhone: jsProfile.jsPhone,
                        jsEmail: jsProfile.email,
                        jsAddress: jsProfile.jsAddress,
                        jsAboutMe: jsProfile.jsAboutMe,
                        jsSkills: jsProfile.jsSkills,
                        jsExperience: jsProfile.jsJobXp,
                        jsImageUrl: jsProfile.jsImageUrl,
                      );

                      //Saving AppliedJob oject to Applied jobs collection

                      await AppliedJobsDBService.saveAppliedJobData(
                          appliedJobData: appliedJob.toJson());

                      //Toggling the job appplied status in jobs collection
                      isJobSaved
                          ? await JobsDBService.jsApplySavedJob(
                              jobProfile: savedJob)
                          : await JobsDBService.jsApplyUnsavedJob(
                              jobProfile: savedJob);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
