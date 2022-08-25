import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/models/applied_jobs.dart';
import 'package:jobrecruitmentapp_hybrid/models/jk_user.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/JobSeeker/apply_job_dialog.dart';
import '../../Employer/HomeScreenPages/add_edit_page.dart';

class JSJobDetailsPage extends StatefulWidget {
  JobProfile? jobPosted;
  bool isJobSaved;
  bool isJobApplied;

  JSJobDetailsPage({
    required this.jobPosted,
    required this.isJobSaved,
    required this.isJobApplied,
  });

  @override
  State<JSJobDetailsPage> createState() => _JSJobDetailsPageState();
}

class _JSJobDetailsPageState extends State<JSJobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 23),
            width: double.maxFinite,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.jobPosted!.jobName ?? "Job Name",
                                style: kHeading2BoldStyle.copyWith(
                                    color: Color(0xFF112E6F))),
                            SizedBox(height: 5),
                            Text(widget.jobPosted!.orgType ?? "orgType",
                                style: kHeading3DarkStyle),
                            SizedBox(height: 5),
                            Text(widget.jobPosted!.jobLocation ?? "location",
                                style: kAppTextDarkBoldStyle),
                            Chip(
                              label: Text(
                                  '\$ ${widget.jobPosted!.salaryPerHr ?? "Salary"} an hour',
                                  style: kAppTextBoldWhiteStyle),
                              backgroundColor: kThemeColor1,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset('assets/images/jobPicIcon.png',
                                height: 69, width: 63),
                          ],
                        ),
                      ],
                    ),
                    //Job Description
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Job Description", style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            widget.jobPosted!.jobDescription ??
                                "jobDescription",
                            style: kAppRegularTextStyle),

                        SizedBox(height: 10),

                        //Job Requirements
                        Text("Requirements", style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            widget.jobPosted!.jobRequirements ?? "requirements",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),

                        //Contact Information and Company Address
                        Text("Contact Information",
                            style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            "Email: ${widget.jobPosted!.empEmail ?? "email"} \nPhone: ${widget.jobPosted!.empPhone ?? "phone"}",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),
                        Text("Company Address", style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            "${widget.jobPosted!.jobAddress ?? "orgAddress"} \n${widget.jobPosted!.jobLocation ?? "location"}",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: kSmallButtonStyle,
                              child: widget.isJobApplied == true
                                  ? Text("Applied")
                                  : Text("Apply Job"),
                              onPressed: widget.isJobApplied == true
                                  ? null
                                  : () {
                                showApplyJobDialog(
                                  context: context,
                                  savedJob: widget.jobPosted!,
                                  userEmail: userEmail!,
                                  isJobSaved: widget.isJobSaved,
                                );
                              },
                            ),
                            SizedBox(width: 17),
                            widget.isJobApplied == true
                                ? Text("")
                                : ElevatedButton(
                              style: kSmallButtonStyle,
                              child: widget.isJobSaved == true
                                  ? Text("Saved")
                                  : Text("Save Job"),
                              onPressed: widget.isJobSaved == true
                                  ? null
                                  : () async {
                                JKUser jsProfile =
                                await UserDBService
                                    .getJKProfile(
                                    email: userEmail!);

                                //Creating AppliedJob Object
                                AppliedJob appliedJob = AppliedJob(
                                  jobID: widget.jobPosted!.jobID,
                                  jobName:
                                  widget.jobPosted!.jobName,
                                  orgType:
                                  widget.jobPosted!.orgType,
                                  jobLocation:
                                  widget.jobPosted!.jobLocation,
                                  salaryPerHr:
                                  widget.jobPosted!.salaryPerHr,
                                  jobDescription: widget
                                      .jobPosted!.jobDescription,
                                  requirements: widget
                                      .jobPosted!.jobRequirements,
                                  empEmail:
                                  widget.jobPosted!.empEmail,
                                  empPhone:
                                  widget.jobPosted!.empPhone,
                                  orgAddress:
                                  widget.jobPosted!.jobAddress,
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

                                await SavedJobsDBService
                                    .saveSavedJobData(
                                    savedJobData:
                                    appliedJob.toJson());
                                setState(() {
                                  widget.isJobSaved = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
