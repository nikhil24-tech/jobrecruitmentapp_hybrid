import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobrecruitmentapp_hybrid/main.dart';
import '../../../constants/style.dart';
import '../../../controllers/job_saved_applied_checker.dart';
import '../../../models/job_profile.dart';
import '../../../widgets/JobSeeker/saved_jobs_widget.dart';

class SavedJobsPage extends StatefulWidget {
  @override
  State<SavedJobsPage> createState() => _SavedJobsPageState();
}

String? userEmail;

class _SavedJobsPageState extends State<SavedJobsPage> {
  @override
  void initState() {
    super.initState();
    //load image from firebase
    getuserDetails();
  }

  getuserDetails() async {
    //get the email from shared prefs
    userEmail = userDataCache.getString("loggedInUserEmail")!;
    setState(() {});
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
            child: Text('Saved Jobs', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map>>(
              stream: FirebaseFirestore.instance
                  .collection('savedJobs')
                  .where("jsEmail", isEqualTo: userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  //Get a list of all the jobs posted by all employers

                  final savedJobs = snapshot.data!.docs
                      .map((doc) => JobProfile.fromDocument(doc))
                      .toList();
                  return JSSavedJobsView(
                      savedJobs: savedJobs, userEmail: userEmail!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Saved Jobs',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                }
              }),
        ],
      ),
    );
  }
}

class JSSavedJobsView extends StatelessWidget {
  List<JobProfile> savedJobs;
  String userEmail;
  JSSavedJobsView({required this.savedJobs, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: savedJobs.length == 0
          ? Center(child: Text('No Saved Jobs', style: kHeading2BoldStyle))
          : ListView.builder(
        itemCount: savedJobs.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              SavedJobWidget(
                savedJob: savedJobs[index],
                userEmail: userEmail,
                isJobSaved: isJobSaved(
                    jobPosting: savedJobs[index], userEmail: userEmail),
                isJobApplied: isJobApplied(
                    jobPosting: savedJobs[index], userEmail: userEmail),
              ),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
