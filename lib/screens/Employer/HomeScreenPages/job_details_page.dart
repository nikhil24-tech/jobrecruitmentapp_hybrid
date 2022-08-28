import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobrecruitmentapp_hybrid/models/applied_jobs.dart';
import 'package:jobrecruitmentapp_hybrid/services/job_kart_db_service.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';

class JobDetailsPage extends StatelessWidget {
  final JobProfile? jobProfile;
  bool isAdmin;
  bool? showApplications;

  JobDetailsPage(
      {required this.isAdmin,
        this.showApplications = false,
        required JobProfile this.jobProfile});

  _handleDelete() {
    JobsDBService.deleteJobPosting(jobID: jobProfile?.jobID ?? "");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23),
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Align(child: Text("JobKart", style: kSmallLogoTextStyle)),
                SizedBox(height: 12),
                Text("Latest Jobs", style: kHeading2BoldStyle),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(0xFFE2E1E1),
                      borderRadius: BorderRadius.circular(23)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(jobProfile!.jobName ?? "Job Name  ",
                                  style: kHeading2BoldStyle.copyWith(
                                      color: Color(0xFF112E6F))),
                              SizedBox(height: 5),
                              Text(jobProfile!.orgType ?? "org type",
                                  style: kHeading3DarkStyle),
                              SizedBox(height: 5),
                              Text(jobProfile!.jobLocation ?? "Location",
                                  style: kAppTextDarkBoldStyle),
                              Chip(
                                label: Text(
                                    '\$${jobProfile!.salaryPerHr} an hour',
                                    style: kAppTextBoldWhiteStyle),
                                backgroundColor: kThemeColor1,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              jobProfile!.orgImageUrl == null
                                  ? Image.asset('assets/images/jobPicIcon.png',
                                  height: 69, width: 63)
                                  : Image.network(
                                jobProfile!.orgImageUrl ?? kLogoImageUrl,
                                height: 69,
                                width: 63,
                                errorBuilder: (a, b, c) {
                                  return SizedBox(
                                    height: 69,
                                    width: 63,
                                    child: Center(
                                      child: Icon(Icons.error),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Job Description
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Job Description",
                              style: kHeading3DarkBoldStyle),
                          SizedBox(height: 10),
                          Text(jobProfile!.jobDescription ?? "job description",
                              style: kAppRegularTextStyle),

                          SizedBox(height: 10),

                          //Job Requirements
                          Text("Requirements", style: kHeading3DarkBoldStyle),
                          SizedBox(height: 10),
                          Text(jobProfile!.jobRequirements ?? "requirements",
                              style: kAppRegularTextStyle),
                          SizedBox(height: 10),

                          //Contact Information and Company Address
                          Text("Contact Information",
                              style: kHeading3DarkBoldStyle),
                          SizedBox(height: 10),
                          Text(
                              "Email: ${jobProfile!.empEmail} \nPhone: ${jobProfile!.empPhone}",
                              style: kAppRegularTextStyle),
                          SizedBox(height: 10),
                          Text("Company Address",
                              style: kHeading3DarkBoldStyle),
                          SizedBox(height: 10),
                          Text(
                              "${jobProfile!.jobAddress} \n${jobProfile!.jobLocation}",
                              style: kAppRegularTextStyle),
                        ],
                      ),
                      SizedBox(height: 15),
                      isAdmin == true
                          ? Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: _handleDelete,
                          color: kDeleteRedColor,
                          child: Text(
                            "Delete Job",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                          : Text(""),
                    ],
                  ),
                ),
                (showApplications ?? false)
                    ? (jobProfile?.applicantEmail ?? "").isEmpty
                    ? _showApplications()
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        "Candidate ${jobProfile?.applicantEmail} is selected"),
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showApplications() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text("Job Applicants"),
        StreamBuilder<QuerySnapshot<Map>>(
          stream: FirebaseFirestore.instance
              .collection('appliedJobs')
              .where('jobID', isEqualTo: jobProfile!.jobID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final jobApplications = snapshot.data!.docs
                  .map((doc) => AppliedJob.fromDocument(doc))
                  .toList();

              //Build a list view of jobs posted by employer
              return jobApplications.length == 0
                  ? Center(
                  child: Text('No Applications', style: kHeading2BoldStyle))
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: jobApplications.length,
                itemBuilder: ((context, index) {
                  return JobApplicationView(
                    jobApplication: jobApplications[index],
                  );
                }),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              print("snapshot doesn't have data");
              return Center(
                  child: Text('Nobody is applied for this job yet',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)));
            }
          },
        ),
      ],
    );
  }
}

class JobApplicationView extends StatelessWidget {
  final AppliedJob? jobApplication;
  const JobApplicationView({Key? key, this.jobApplication}) : super(key: key);
  _handleAccept() {
    JobsDBService.updateJobData(
        docIdToUpdate: jobApplication?.jobID ?? "",
        jobData: {"applicant_selected": jobApplication?.jsEmail ?? ""});

    Get.back();
  }

  _handleReject() {
    AppliedJobsDBService.deleteAppliedJobByJobID(
        jobID: jobApplication?.jobID ?? "");

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobApplication!.jsName ?? ""),
                SizedBox(height: 3),
                Text(jobApplication!.jsEmail ?? ""),
                SizedBox(height: 3),
                Text("Experience : - " + (jobApplication!.jsExperience ?? "")),
                SizedBox(height: 3),
              ],
            ),
          ),
          Spacer(),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: _handleAccept,
            color: kThemeColor1,
            child: Text(
              "Accept",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: _handleReject,
            color: kDeleteRedColor,
            child: Text(
              "Reject",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
