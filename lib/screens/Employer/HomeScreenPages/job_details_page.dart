import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';

class JobDetailsPage extends StatelessWidget {
  final JobProfile? jobProfile;
  bool isAdmin;

  JobDetailsPage({required this.isAdmin, required JobProfile this.jobProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            label: Text('\$${jobProfile!.salaryPerHr} an hour',
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
                                  width: 63),
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
                      Text("Company Address", style: kHeading3DarkBoldStyle),
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

                        )
                      : Text(""),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
