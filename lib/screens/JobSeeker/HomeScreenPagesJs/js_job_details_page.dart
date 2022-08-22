import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/JobSeeker/apply_job_dialog.dart';
import '../../Employer/HomeScreenPages/add_edit_page.dart';

class JSJobDetailsPage extends StatelessWidget {
  JobProfile? jobPosted;
  bool isJobSaved;
  bool isJobApplied;

  JSJobDetailsPage(
      {required this.jobPosted,
      required this.isJobSaved,
      required this.isJobApplied});

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
                            Text(jobPosted!.jobName ?? "Job Name",
                                style: kHeading2BoldStyle.copyWith(
                                    color: Color(0xFF112E6F))),
                            SizedBox(height: 5),
                            Text(jobPosted!.orgType ?? "orgType",
                                style: kHeading3DarkStyle),
                            SizedBox(height: 5),
                            Text(jobPosted!.jobLocation ?? "location",
                                style: kAppTextDarkBoldStyle),
                            Chip(
                              label: Text(
                                  '\$ ${jobPosted!.salaryPerHr ?? "Salary"} an hour',
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
                        Text(jobPosted!.jobDescription ?? "jobDescription",
                            style: kAppRegularTextStyle),

                        SizedBox(height: 10),

                        //Job Requirements
                        Text("Requirements", style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(jobPosted!.jobRequirements ?? "requirements",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),

                        //Contact Information and Company Address
                        Text("Contact Information",
                            style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            "Email: ${jobPosted!.empEmail ?? "email"} \nPhone: ${jobPosted!.empPhone ?? "phone"}",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),
                        Text("Company Address", style: kHeading3DarkBoldStyle),
                        SizedBox(height: 10),
                        Text(
                            "${jobPosted!.jobAddress ?? "orgAddress"} \n${jobPosted!.jobLocation ?? "location"}",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: kSmallButtonStyle,
                              child: isJobApplied == true
                                  ? Text("Applied")
                                  : Text("Apply Job"),
                              onPressed: isJobApplied == true
                                  ? null
                                  : () {
                                      showApplyJobDialog(
                                        context: context,
                                        savedJob: jobPosted!,
                                        userEmail: userEmail!,
                                        isJobSaved: isJobSaved,
                                      );
                                    },
                            ),
                            SizedBox(width: 17),
                            isJobApplied == true
                                ? Text("")
                                : ElevatedButton(
                                    style: kSmallButtonStyle,
                                    child: isJobSaved == true
                                        ? Text("Saved")
                                        : Text("Save Job"),
                                    onPressed: isJobSaved == true
                                        ? null
                                        : () async {
                                            await JobsDBService.jsSaveJob(
                                                jobProfile: jobPosted!);
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
