import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../constants/style.dart';
import '../../../models/applied_jobs.dart';
import '../../../services/job_kart_db_service.dart';

class EmployerCandidateDetailsPage extends StatefulWidget {
  final AppliedJob appliedJob;

  var appliedJobsStreamController;

  EmployerCandidateDetailsPage({super.key, required this.appliedJob});

  @override
  State<EmployerCandidateDetailsPage> createState() =>
      _EmployerCandidateDetailsPageState();
}

class _EmployerCandidateDetailsPageState
    extends State<EmployerCandidateDetailsPage> {
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
              Align(
                child: Text(
                  "JobKart",
                  style: kSmallLogoTextStyle,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kContainerBackgroundColor,
                    borderRadius: BorderRadius.circular(23)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 66,
                          width: 66,
                          child: widget.appliedJob.jsImageUrl == null
                              ? CircleAvatar(backgroundColor: Color(0xFFD9D9D9))
                              : CircleAvatar(
                              backgroundImage: Image.network(
                                  widget.appliedJob.jsImageUrl!)
                                  .image),
                        ),
                        SizedBox(width: 11),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${widget.appliedJob.jsName}",
                              style: kHeading2BoldStyle,
                            ),
                            SizedBox(height: 5),
                            Text("Applied For:", style: kAppRegularTextStyle),
                            Text(widget.appliedJob.jobName!,
                                style: kAppRegularTextStyle),
                            SizedBox(height: 5),
                            Text(
                                widget.appliedJob.jobLocation ?? "Job Location",
                                style: kAppTextDarkBoldStyle),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Details",
                            style: kHeading2BoldStyle.copyWith(
                                color: Color.fromRGBO(78, 77, 77, 1))),
                        SizedBox(height: 5),
                        Text("Mobile Phone", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsPhone!,
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Email Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsEmail ?? "email",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsAddress ?? "address",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 15),
                        Text("About Me", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsAboutMe ?? "About Me",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 15),
                        Text("Skills", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsSkills ?? "Skills",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 15),
                        Text("Experience", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.appliedJob.jsExperience ?? "Experience",
                            style: kAppRegularTextStyle),
                      ],
                    ),

                    SizedBox(height: 27),

                    //Approve or Reject Candidate Buttons
                    // if isApproved is null a decision is not made and hence both buttons are visible
                    widget.appliedJob.isApproved == null
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: kSmallButtonStyle,
                          child: Text("Approve"),
                          onPressed: () async {
                            await AppliedJobsDBService.approveJob(
                                jobID: widget.appliedJob.jobID!);
                            Navigator.pop(context);
                            MotionToast.success(
                                description: Text("Approved",
                                    style: kBigButtonTextStyle))
                                .show(context);
                          },
                        ),
                        SizedBox(width: 17),
                        ElevatedButton(
                          style: kSmallButtonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  kDeleteRedColor)),
                          child: Text("Reject"),
                          onPressed: () async {
                            await AppliedJobsDBService.rejectJob(
                                jobID: widget.appliedJob.jobID!);
                            Navigator.pop(context);
                            MotionToast.error(
                                description: Text("Rejected",
                                    style: kBigButtonTextStyle))
                                .show(context);
                          },
                        ),
                      ],
                    )
                    // if isApproved is not null a decision IS made and hence only on button is active

                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: kSmallButtonStyle,
                          child: widget.appliedJob.isApproved == true
                              ? Text("Approved")
                              : Text("Approve"),
                          onPressed: widget.appliedJob.isApproved == true
                              ? null
                              : () async {
                            await AppliedJobsDBService.approveJob(
                                jobID: widget.appliedJob.jobID!);

                            Navigator.pop(context);
                            MotionToast.success(
                                description: Text("Approved",
                                    style: kBigButtonTextStyle))
                                .show(context);
                          },
                        ),
                        SizedBox(width: 17),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(23)),
                                fixedSize: Size(138, 39),
                                textStyle: kSmallButtonTextStyle,
                                primary: kDeleteRedColor),
                            child: widget.appliedJob.isApproved == true
                                ? Text("Reject")
                                : Text("Rejected"),
                            onPressed: widget.appliedJob.isApproved ==
                                true
                                ? () async {
                              await AppliedJobsDBService.rejectJob(
                                  jobID: widget.appliedJob.jobID!);
                              Navigator.pop(context);
                              MotionToast.error(
                                  description: Text("Rejected",
                                      style:
                                      kBigButtonTextStyle))
                                  .show(context);
                            }
                                : null),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
            ]),
          ),
        ),
      ),
    );
  }
}
