import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../services/job_kart_db_service.dart';

deleteJobDialog(
    {required BuildContext context,
      required String jobID,
      required bool popFromDetailsPage}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Text("Are you sure you want to delete this job?",
            style: kHeading2RegularStyle),
        actions: <Widget>[
          Row(
            children: [
              ElevatedButton(
                style: kSmallButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(kGoogleRed)),
                child: Text("OK",
                    style: kHeading3RegularStyle.copyWith(color: Colors.white)),
                onPressed: () async {
                  // Delete job from database
                  await JobsDBService.deleteJobPosting(jobID: jobID);
                  // Delete all applications for this job
                  await AppliedJobsDBService.deleteAppliedJobByJobID(
                      jobID: jobID);
                  int _num_of_screen_to_pop = 0;
                  popFromDetailsPage == true
                      ? Navigator.popUntil(context, (route) {
                    return _num_of_screen_to_pop++ == 2;
                  })
                      : Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10),
              ElevatedButton(
                style: kSmallButtonStyle,
                child: Text("Cancel",
                    style: kHeading3RegularStyle.copyWith(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
