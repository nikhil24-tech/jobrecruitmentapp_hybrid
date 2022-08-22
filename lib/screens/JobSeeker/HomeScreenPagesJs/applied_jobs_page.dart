import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../models/applied_jobs.dart';

class AppliedJobsPage extends StatefulWidget {
  @override
  State<AppliedJobsPage> createState() => _AppliedJobsPageState();
}

String? userEmail;

class _AppliedJobsPageState extends State<AppliedJobsPage> {
  @override
  void initState() {
    super.initState();
    //load image from firebase
    getuserDetails();
  }

  getuserDetails() async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    userEmail = userDataCache.getString("loggedInUserEmail")!;
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
            child: Text('Applied Jobs', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map>>(
              stream: FirebaseFirestore.instance
                  .collection('appliedJobs')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  //Get a list of all user applied jobs

                  final appliedJobs = snapshot.data!.docs
                      .map((doc) => AppliedJob.fromDocument(doc))
                      .where((appliedJob) => appliedJob.jsEmail == userEmail)
                      .toList();

                  //Build a list view of jobs posted by employer
                  return JSAppliedJobsView(
                      appliedJobs: appliedJobs, userEmail: userEmail!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Applied Jobs',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                } else {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Applied Jobs',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                }
              }),
        ],
      ),
    );
  }
}

class JSAppliedJobsView extends StatelessWidget {
  List<AppliedJob> appliedJobs;
  String userEmail;
  JSAppliedJobsView({required this.appliedJobs, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: appliedJobs.length,
        itemBuilder: ((context, index) {
          return Column(
          );
        }),
      ),
    );
  }
}
