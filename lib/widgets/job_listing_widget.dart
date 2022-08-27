import 'package:flutter/material.dart';
import '../constants/style.dart';
import '../models/job_profile.dart';
import '../screens/Employer/HomeScreenPages/job_details_page.dart';

class JobListingWidget extends StatelessWidget {
//A Row inside a contaiber with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  bool isAdmin;
  JobProfile? jobProfile;

  JobListingWidget(
      {required this.isAdmin, required JobProfile this.jobProfile});

  @override
  Widget build(BuildContext context) {
    print(jobProfile!.orgImageUrl);
    return Container(
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
                  jobProfile!.jobName!.length > 18
                      ? (jobProfile!.jobName!.substring(0, 15)) + '...'
                      : jobProfile!.jobName!,
                  style: kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
              SizedBox(height: 5),
              Text(jobProfile!.orgType ?? "OrgType", style: kHeading3DarkStyle),
              SizedBox(height: 5),
              Text(jobProfile!.jobLocation ?? "location",
                  style: kAppTextDarkBoldStyle),
              Chip(
                label: Text('\$ ${jobProfile!.salaryPerHr ?? "20"} per hour',
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
                  : Image(
                  image: NetworkImage(
                    jobProfile!.orgImageUrl ?? kLogoImageUrl,
                  ),
                  errorBuilder: (ctx, exception, stackTrace) {
                    return SizedBox(
                      height: 69,
                      width: 63,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ); //THE WIDGET YOU WANT TO SHOW IF URL NOT RETURN IMAGE
                  },
                  height: 69,
                  width: 63),
              SizedBox(height: 5),
              ElevatedButton(
                style: kSmallButtonStyle,
                child: Text("View Job"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailsPage(
                        isAdmin: isAdmin,
                        jobProfile: jobProfile!,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
