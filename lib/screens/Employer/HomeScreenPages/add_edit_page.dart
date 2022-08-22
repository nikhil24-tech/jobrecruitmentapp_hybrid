import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../models/jk_user.dart';
import '../../../services/job_kart_db_service.dart';
import 'add_new_job_page.dart';
import 'employer_posted_jobs_page.dart';

//PageController _pageViewController = PageController(initialPage: 0);

class AddEditJobsPage extends StatefulWidget {
  @override
  State<AddEditJobsPage> createState() => _AddEditJobsPageState();
}

String empLogoImageUrl = "";
String? userEmail;
JKUser? empProfile;

class _AddEditJobsPageState extends State<AddEditJobsPage> {
  @override
  void initState() {
    getEmpProfile();
    super.initState();
  }

  getEmpProfile() async {
    final userDataCache = await SharedPreferences.getInstance();
    userEmail = await userDataCache.getString("loggedInUserEmail")!;
    empProfile = await UserDBService.getJobSeekerProfile(email: userEmail!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('JobKart', style: kSmallLogoTextStyle),
        Spacer(),
        ElevatedButton(
          style: kBigButtonStyle,
          child: Text("Add A New Job"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddANewJobPage(empProfile: empProfile!),
            ),
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: kBigButtonStyle,
          child: Text("Edit Jobs"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployerPostedJobsPage(),
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
