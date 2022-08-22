import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/style.dart';
import '../../../controllers/user_details_contorller.dart';
import '../../../models/job_profile.dart';
import '../../../widgets/delete_job_dialog.dart';
import 'employer_posted_jobs_page.dart';
import 'posted_job_edit_page.dart';

class EmployerPostedJobDetailsPage extends StatelessWidget {
  JobProfile jobProfile;
  EmployerPostedJobDetailsPage({required this.jobProfile});

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
                          Text(jobProfile.jobName!,
                              style: kHeading2BoldStyle.copyWith(
                                  color: Color(0xFF112E6F))),
                          SizedBox(height: 5),
                          Text(jobProfile.orgType!, style: kHeading3DarkStyle),
                          SizedBox(height: 5),
                          Text(jobProfile.jobLocation!,
                              style: kAppTextDarkBoldStyle),
                          Chip(
                            label: Text('\$${jobProfile.salaryPerHr} an hour',
                                style: kAppTextBoldWhiteStyle),
                            backgroundColor: kThemeColor1,
                          ),
                        ],
                      ),
                      Consumer<UserDetailsController>(
                        builder: ((context, userDetails, child) {
                          userDetails.getUserDetails();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              userDetails.userImageUrl == null
                                  ? Image.asset('assets/images/jobPicIcon.png',
                                  height: 69, width: 63)
                                  : Image.network(
                                  userDetails.userImageUrl ?? kLogoImageUrl,
                                  height: 69,
                                  width: 63),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                  //Job Description
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Job Description", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(jobProfile.jobDescription!,
                          style: kAppRegularTextStyle),

                      SizedBox(height: 10),

                      //Job Requirements
                      Text("Requirements", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(jobProfile.jobRequirements!,
                          style: kAppRegularTextStyle),
                      SizedBox(height: 10),

                      //Contact Information and Company Address
                      Text("Contact Information",
                          style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(
                          "Email: ${jobProfile.empEmail} \nPhone: ${jobProfile.empPhone}",
                          style: kAppRegularTextStyle),
                      SizedBox(height: 10),
                      Text("Company Address", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(
                          "${jobProfile.jobAddress} \n${jobProfile.jobLocation}",
                          style: kAppRegularTextStyle),
                    ],
                  ),
                  SizedBox(height: 17),
                  //Edit and Delete Job Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: kSmallButtonStyle.copyWith(
                            backgroundColor:
                            MaterialStateProperty.all(kDeleteRedColor)),
                        child: Text("Delete Job"),
                        onPressed: () async {
                          await deleteJobDialog(
                              context: context,
                              jobID: jobProfile.jobID!,
                              popFromDetailsPage: true);
                        },
                      ),
                      SizedBox(width: 17),
                      ElevatedButton(
                        style: kSmallButtonStyle,
                        child: Text("Edit Job"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostedJobEditPage(
                                jobProfile: jobProfile,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
