import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../models/job_profile.dart';
import '../../screens/Employer/HomeScreenPages/employer_posted_job_details.dart';
import '../../screens/Employer/HomeScreenPages/posted_job_edit_page.dart';
import 'delete_job_dialog.dart';

class EditableJobListingWidget extends StatelessWidget {
//A Row inside a container with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  JobProfile jobProfile;
  EditableJobListingWidget({required this.jobProfile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EmployerPostedJobDetailsPage(jobProfile: jobProfile),
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
                    jobProfile.jobName!.length > 18
                        ? (jobProfile.jobName!.substring(0, 15)) + '...'
                        : jobProfile.jobName!,
                    style:
                    kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
                SizedBox(height: 5),
                Text(
                  jobProfile.orgType!,
                  style: kHeading3DarkStyle,
                ),
                SizedBox(height: 5),
                Text(jobProfile.jobAddress!, style: kAppTextDarkBoldStyle),
                Chip(
                  label: Text('\$' + jobProfile.salaryPerHr! + ' per hour',
                      style: kAppTextBoldWhiteStyle),
                  backgroundColor: kThemeColor1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: kSmallButtonStyle,
                  child: Text("Edit Job"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => PostedJobEditPage(
                          jobProfile: jobProfile,
                        )),
                      ),
                    );
                  },
                ),
                SizedBox(height: 17),
                ElevatedButton(
                  style: kSmallButtonStyle.copyWith(
                      backgroundColor:
                      MaterialStateProperty.all(kDeleteRedColor)),
                  child: Text("Delete Job"),
                  onPressed: () async {
                    //alert dialog to confirm deletion of job
                    await deleteJobDialog(
                        context: context,
                        jobID: jobProfile.jobID!,
                        popFromDetailsPage: false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
