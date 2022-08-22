import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../models/applied_jobs.dart';
import '../../../widgets/candidate_summary_widget.dart';

class JobSeekersAppliedPage extends StatefulWidget {
  @override
  State<JobSeekersAppliedPage> createState() => _JobSeekersAppliedPageState();
}

String? empLogoUrl;

class _JobSeekersAppliedPageState extends State<JobSeekersAppliedPage> {
  String? empEmail;
  @override
  void initState() {
    //load image from firebase
    getEmployerEmail();
    super.initState();
  }

  getEmployerEmail() async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    empEmail = userDataCache.getString("loggedInUserEmail");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Text('JobKart', style: kSmallLogoTextStyle),
          SizedBox(height: 17),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Job Applications', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map>>(
              stream: FirebaseFirestore.instance
                  .collection("appliedJobs")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final appliedJobs = snapshot.data!.docs
                      .map((doc) => AppliedJob.fromDocument(doc))
                      .where(
                          (appliedJob) => appliedJob.empEmail == empEmail)
                      .toList();

                  //Build a list view of jobs posted by employer
                  return AppliedJobsView(
                    appliedJobs: appliedJobs,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Applications to display',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                }
              }),
        ],
      ),
    );
  }
}

class AppliedJobsView extends StatefulWidget {
  final List<AppliedJob> appliedJobs;

  const AppliedJobsView({required List<AppliedJob> this.appliedJobs});

  @override
  State<AppliedJobsView> createState() => _AppliedJobsViewState();
}

class _AppliedJobsViewState extends State<AppliedJobsView> {
  @override
  Widget build(BuildContext context) {
    return widget.appliedJobs.length == 0
        ? Center(
            child: Text('No job applicants', style: kHeading2BoldStyle),
          )
        : Flexible(
            child: ListView.builder(
              itemCount: widget.appliedJobs.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    CandidateSummaryWidget(
                      appliedJob: widget.appliedJobs[index],
                    ),
                    SizedBox(height: 15),
                  ],
                );
              }),
            ),
          );
  }
}
