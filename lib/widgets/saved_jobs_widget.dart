import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../services/job_kart_db_service.dart';
import '../models/job_profile.dart';

class SavedJobWidget extends StatelessWidget {
//A Row inside a contaiber with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  final JobProfile savedJob;
  final String userEmail;
  bool isJobSaved;
  bool isJobApplied;

  SavedJobWidget(
      {required this.savedJob,
        required this.userEmail,
        required this.isJobSaved,
        required this.isJobApplied});
  @override
  Widget build(BuildContext context) {
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
                  savedJob.jobName!.length > 18
                      ? (savedJob.jobName!.substring(0, 15)) + '...'
                      : savedJob.jobName!,
                  style:
                  kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
              SizedBox(height: 5),
              Text(
                savedJob.orgType ?? "Org Type",
                style: kHeading3DarkStyle,
              ),
              SizedBox(height: 5),
              Text(savedJob.jobLocation ?? "location",
                  style: kAppTextDarkBoldStyle),
              Chip(
                label: Text('\$ ${savedJob.salaryPerHr} an hour',
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
                child:
                isJobApplied == true ? Text("Applied") : Text("Apply Job"),
                onPressed: isJobApplied == true
                    ? null
                    : () {
                  showApplyJobDialog(
                      context: context,
                      savedJob: savedJob,
                      userEmail: userEmail,
                      isJobSaved: isJobSaved);
                },
              ),
              SizedBox(height: 17),
              isJobApplied == true
                  ? Text("")
                  : ElevatedButton(
                style: kSmallButtonStyle.copyWith(
                    backgroundColor:
                    MaterialStateProperty.all(kDeleteRedColor)),
                child: Text("Unsave Job"),
                onPressed: () async {
                  await JobsDBService.jsUnSaveJob(jobProfile: savedJob);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showApplyJobDialog({required BuildContext context, required JobProfile savedJob, required String userEmail, required bool isJobSaved}) {}
}
