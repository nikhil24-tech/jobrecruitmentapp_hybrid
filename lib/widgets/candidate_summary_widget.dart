import 'package:flutter/material.dart';

import '../constants/style.dart';
import '../models/applied_jobs.dart';




class CandidateSummaryWidget extends StatefulWidget {
  final AppliedJob appliedJob;

  CandidateSummaryWidget({required this.appliedJob});

  @override
  State<CandidateSummaryWidget> createState() => _CandidateSummaryWidgetState();
}

class _CandidateSummaryWidgetState extends State<CandidateSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 66,
                width: 66,
                child: widget.appliedJob.jsImageUrl == null
                    ? CircleAvatar(backgroundColor: Color(0xFFD9D9D9))
                    : CircleAvatar(
                        backgroundImage:
                            Image.network(widget.appliedJob.jsImageUrl!).image),
              ),
              SizedBox(width: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${widget.appliedJob.jsName}",
                      style: kHeading2BoldStyle),
                  SizedBox(height: 5),
                  Text(
                      "Applied For: ${widget.appliedJob.jobName!.length > 18 ? (widget.appliedJob.jobName!.substring(0, 15)) + '...' : widget.appliedJob.jobName}",
                      style: kHeading3DarkStyle),
                  SizedBox(height: 5),
                  Text(widget.appliedJob.jobLocation ?? "Job Location",
                      style: kAppTextDarkBoldStyle),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.appliedJob.isApproved != null
                      ? widget.appliedJob.isApproved == true
                          ? Text("Approved ✔",
                              style: kHeading2BoldStyle.copyWith(
                                  color: Colors.green))
                          : Text("Rejected ❌ ",
                              style: kHeading2BoldStyle.copyWith(
                                  color: Colors.red))
                      : Text(""),
                ),
                Spacer(),
                ElevatedButton(
                  style: kSmallButtonStyle,
                  child: Text("View Candidate"),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
