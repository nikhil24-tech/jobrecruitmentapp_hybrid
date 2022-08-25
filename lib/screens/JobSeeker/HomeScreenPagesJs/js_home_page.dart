import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../controllers/job_saved_applied_checker.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/JobSeeker/js_job_listing_widget.dart';

class JobSeekerHomePage extends StatefulWidget {
  @override
  State<JobSeekerHomePage> createState() => _JobSeekerHomePageState();
}
//user details that will be initialized by getUserDetails() method called by
//init state method of this class

String? userEmail;
String? userProfilePicUrl;

class _JobSeekerHomePageState extends State<JobSeekerHomePage> {
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
    userProfilePicUrl = await UserDBService.getJSImageUrl(userEmail!);
    // saving the image url in shared prefs
    await userDataCache.setString(
        'loggedInUserImageUrl', userProfilePicUrl ?? kLogoImageUrl);
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
            child: Text('Latest Jobs', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map>>(
              stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  //Get a list of all the jobs posted by all employers

                  final jobsPostedByAllOrg = snapshot.data!.docs
                      .map((doc) => JobProfile.fromDocument(doc))
                      .toList();

                  //Build a list view of jobs posted by employer
                  return JobsPostedByAllOrgView(
                      userEmail: userEmail!,
                      jobsPostedByAllOrg: jobsPostedByAllOrg);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Jobs to display',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                }
              }),
        ],
      ),
    );
  }
}

class JobsPostedByAllOrgView extends StatelessWidget {
  final List<JobProfile> jobsPostedByAllOrg;
  String userEmail;
  JobsPostedByAllOrgView(
      {required List<JobProfile> this.jobsPostedByAllOrg,
        required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: jobsPostedByAllOrg.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              JobSeekerJobListingWidget(
                userEmail:userEmail,
                jobPosted: jobsPostedByAllOrg[index],
                // isJobSaved: isJobSaved(
                //     jobPosting: jobsPostedByAllOrg[index],
                //     userEmail: userEmail),
                // isJobApplied: isJobApplied(
                //     jobPosting: jobsPostedByAllOrg[index],
                //     userEmail: userEmail),
              ),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
