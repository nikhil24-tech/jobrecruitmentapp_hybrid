import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../widgets/job_listing_widget.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
              child: Text('Latest Jobs', style: kHeading2BoldStyle),
            ),
            SizedBox(height: 12),
            StreamBuilder<QuerySnapshot<Map>>(
                stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final jobsPostedByAllOrgs = snapshot.data!.docs
                        .map((doc) => JobProfile.fromDocument(doc))
                        .toList();

                    //Build a list view of jobs posted by employer
                    return JobsPostedByOrgView(
                        jobsPostedByallOrg: jobsPostedByAllOrgs);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    print("snapshot doesn't have data");
                    return Center(
                      child: Text('No Jobs to display',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class JobsPostedByOrgView extends StatelessWidget {
  final List<JobProfile> jobsPostedByallOrg;
  const JobsPostedByOrgView(
      {required List<JobProfile> this.jobsPostedByallOrg});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: jobsPostedByallOrg.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              JobListingWidget(
                isAdmin: true,
                jobProfile: jobsPostedByallOrg[index],
              ),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
