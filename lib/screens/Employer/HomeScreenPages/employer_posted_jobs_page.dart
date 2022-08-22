import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../widgets/editable_job_listing.dart';

class EmployerPostedJobsPage extends StatefulWidget {
  @override
  State<EmployerPostedJobsPage> createState() => _EmployerPostedJobsPageState();
}

class _EmployerPostedJobsPageState extends State<EmployerPostedJobsPage> {
  String? empEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //load image from firebase
    getEmployerEmail();
  }

  getEmployerEmail() async {
    //get the email from shared prefs
    final userDataCache = await SharedPreferences.getInstance();
    empEmail = userDataCache.getString("loggedInUserEmail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Text("JobKart", style: kSmallLogoTextStyle),
              SizedBox(height: 27),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your Posted Jobs", style: kHeading2BoldStyle)),
              SizedBox(height: 15),
              StreamBuilder<QuerySnapshot<Map>>(
                  stream:
                  FirebaseFirestore.instance.collection('jobs').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      final jobsPostedByOrg = snapshot.data!.docs
                          .map((doc) => JobProfile.fromDocument(doc))
                          .where((empProfile) {
                        return empProfile.empEmail == empEmail;
                      }).toList();

                      //Build a list view of jobs posted by employer
                      return EditableJobsPostedByOrgView(
                          jobsPostedByOrg: jobsPostedByOrg);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child:CircularProgressIndicator());
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
        ),
      ),
    );
  }
}

class EditableJobsPostedByOrgView extends StatelessWidget {
  final List<JobProfile> jobsPostedByOrg;
  const EditableJobsPostedByOrgView(
      {required List<JobProfile> this.jobsPostedByOrg});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: jobsPostedByOrg.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              EditableJobListingWidget(
                jobProfile:jobsPostedByOrg[index] ,
              ),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
