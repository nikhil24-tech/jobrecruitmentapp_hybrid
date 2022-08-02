import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../screens/Employer/HomeScreenPages/employer_posted_job_details.dart';
import '../../screens/Employer/HomeScreenPages/posted_job_edit_page.dart';
import 'delete_job_dialog.dart';

class EditableJobListingWidget extends StatelessWidget {
//A Row inside a container with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  String jobName;
  String orgType;
  String orgAddress;
  String salary;
  String jobID;
  String location;
  String contactEmail;
  String phone;
  String jobDescription;
  String requirements;

  EditableJobListingWidget({
    required this.jobName,
    required this.orgType,
    required this.orgAddress,
    required this.salary,
    required this.jobID,
    required this.location,
    required this.contactEmail,
    required this.phone,
    required this.jobDescription,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployerPostedJobDetailsPage(
                jobId: jobID,
                jobName: jobName,
                orgType: orgType,
                location: location,
                salary: salary,
                jobDescription: jobDescription,
                requirements: requirements,
                contactEmail: contactEmail,
                phone: phone,
                orgAddress: orgAddress),
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
                    jobName.length > 18
                        ? (jobName.substring(0, 15)) + '...'
                        : jobName,
                    style:
                    kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
                SizedBox(height: 5),
                Text(
                  orgType,
                  style: kHeading3DarkStyle,
                ),
                SizedBox(height: 5),
                Text(orgAddress, style: kAppTextDarkBoldStyle),
                Chip(
                  label: Text('\$' + salary + ' per hour',
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
                          jobID: jobID,
                          jobName: jobName,
                          orgType: orgType,
                          orgAddress: orgAddress,
                          location: location,
                          contactEmail: contactEmail,
                          phone: phone,
                          salary: salary,
                          jobDescription: jobDescription,
                          requirements: requirements,
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
                    await deleteJobDialog(context: context, jobID: jobID);
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
