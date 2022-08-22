import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/job_listing_widget.dart';

class jobsPage extends StatefulWidget {
  @override
  State<jobsPage> createState() => _jobsPageState();
}

String? empLogoUrl;
String? empEmail;

class _jobsPageState extends State<jobsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //load image from firebase
    getEmployerEmail();
    setEmpImageUrlInCache();
  }

  getEmployerEmail() async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    empEmail = userDataCache.getString("loggedInUserEmail");
    print("The email of logged in user is $empEmail");
  }

  setEmpImageUrlInCache() async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    empEmail = userDataCache.getString("loggedInUserEmail");
    empLogoUrl = await UserDBService.getOrgImageUrl(empEmail!);
    // saving the image url in shared prefs
    await userDataCache.setString(
        'loggedInUserImageUrl', empLogoUrl ?? kLogoImageUrl);
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
                  final jobsPostedByOrg = snapshot.data!.docs
                      .map((doc) => JobProfile.fromDocument(doc))
                      .where((jobProfile) {
                    return jobProfile.empEmail == empEmail;
                  }).toList();

                  //Build a list view of jobs posted by employer
                  return JobsPostedByOrgView(jobsPostedByOrg: jobsPostedByOrg);
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

class JobsPostedByOrgView extends StatelessWidget {
  final List<JobProfile> jobsPostedByOrg;
  const JobsPostedByOrgView({required List<JobProfile> this.jobsPostedByOrg});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: jobsPostedByOrg.length == 0
          ? Center(child: Text('No Jobs', style: kHeading2BoldStyle))
          : ListView.builder(
        itemCount: jobsPostedByOrg.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              JobListingWidget(
                isAdmin: false,
                jobProfile: jobsPostedByOrg[index],
              ),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
