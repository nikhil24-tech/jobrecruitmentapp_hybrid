import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/models/applied_jobs.dart';
import 'package:jobrecruitmentapp_hybrid/models/jk_user.dart';
import '../../constants/style.dart';
import '../../models/job_profile.dart';
import '../../screens/JobSeeker/HomeScreenPagesJs/js_job_details_page.dart';
import '../../services/job_kart_db_service.dart';
import 'apply_job_dialog.dart';

class JobSeekerJobListingWidget extends StatefulWidget {
//A Row inside a contaiber with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  String? employerImageUrl;
  JobProfile? jobPosted;
  String? userEmail;
  // bool isJobSaved;
  // bool isJobApplied;

  JobSeekerJobListingWidget({
    this.jobPosted,
    this.userEmail,
    this.employerImageUrl,
    // required this.isJobSaved,
    // required this.isJobApplied,
  });

  @override
  State<JobSeekerJobListingWidget> createState() =>
      _JobSeekerJobListingWidgetState();
}

class _JobSeekerJobListingWidgetState extends State<JobSeekerJobListingWidget> {
  bool isLoading = true;
  bool isSaved = true;
  bool isApplied = true;
  @override
  void initState() {
    // TODO: implement initState
    get();
  }

  get() async {
    isSaved = await SavedJobsDBService.getWhetherJobisSavedOrNot(
        jobId: widget.jobPosted!.jobID, jsEmail: widget.userEmail);

    isApplied = await AppliedJobsDBService.getWhetherJobisAppliedOrNot(
        jobId: widget.jobPosted!.jobID, jsEmail: widget.userEmail);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox()
        : GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JSJobDetailsPage(
              jobPosted: widget.jobPosted,
              isJobSaved: isSaved,
              isJobApplied: isApplied,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xAAE2E1E1),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    widget.jobPosted!.jobName!.length > 18
                        ? (widget.jobPosted!.jobName!.substring(0, 15)) +
                        '...'
                        : widget.jobPosted!.jobName!,
                    style: kHeading2BoldStyle.copyWith(
                        color: Color(0xFF112E6F))),
                SizedBox(height: 5),
                Text(widget.jobPosted!.orgType ?? "OrgType",
                    style: kHeading3DarkStyle),
                SizedBox(height: 5),
                Text(widget.jobPosted!.jobLocation ?? "location",
                    style: kAppTextDarkBoldStyle),
                Chip(
                  label: Text(
                      '\$ ${widget.jobPosted!.salaryPerHr ?? "20"} per hour',
                      style: kAppTextBoldWhiteStyle),
                  backgroundColor: kThemeColor1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: kSmallButtonStyle,
                      child: isApplied == true
                          ? Text("Applied")
                          : Text("Apply Job"),
                      onPressed: isApplied == true
                          ? null
                          : () {
                        showApplyJobDialog(
                          context: context,
                          savedJob: widget.jobPosted!,
                          userEmail: widget.userEmail!,
                          isJobSaved: isSaved,
                        );
                        setState(() {
                          isApplied = true;
                        });
                      },
                    ),
                    SizedBox(height: 17),
                    isApplied == true
                        ? Text("")
                        : ElevatedButton(
                      style: kSmallButtonStyle,
                      child: isSaved == true
                          ? Text("Saved")
                          : Text("Save Job"),
                      onPressed: isSaved == true
                          ? null
                          : () async {
                        // await JobsDBService.jsSaveJob(
                        //     jobProfile: widget.jobPosted!);
//Getting User Profile from DB
                        JKUser jsProfile =
                        await UserDBService.getJKProfile(
                            email: widget.userEmail!);

                        //Creating AppliedJob Object
                        AppliedJob appliedJob = AppliedJob(
                          jobID: widget.jobPosted!.jobID,
                          jobName: widget.jobPosted!.jobName,
                          orgType: widget.jobPosted!.orgType,
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
                          isSaved = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
