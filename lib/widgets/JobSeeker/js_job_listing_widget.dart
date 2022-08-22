import 'package:flutter/material.dart';
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
  bool isJobSaved;
  bool isJobApplied;

  JobSeekerJobListingWidget(
      {this.jobPosted,
        this.userEmail,
        this.employerImageUrl,
        required this.isJobSaved,
        required this.isJobApplied});

  @override
  State<JobSeekerJobListingWidget> createState() =>
      _JobSeekerJobListingWidgetState();
}

class _JobSeekerJobListingWidgetState extends State<JobSeekerJobListingWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JSJobDetailsPage(
                    jobPosted: widget.jobPosted,
                    isJobSaved: widget.isJobSaved,
                    isJobApplied: widget.isJobApplied)));
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
                        ? (widget.jobPosted!.jobName!.substring(0, 15)) + '...'
                        : widget.jobPosted!.jobName!,
                    style:
                    kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
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
                      child: widget.isJobApplied == true
                          ? Text("Applied")
                          : Text("Apply Job"),
                      onPressed: widget.isJobApplied == true
                          ? null
                          : () {
                        showApplyJobDialog(
                          context: context,
                          savedJob: widget.jobPosted!,
                          userEmail: widget.userEmail!,
                          isJobSaved: widget.isJobSaved,
                        );
                      },
                    ),
                    SizedBox(height: 17),
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
                        await JobsDBService.jsSaveJob(
                            jobProfile: widget.jobPosted!);
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
