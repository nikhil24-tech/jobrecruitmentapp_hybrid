import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import 'add_new_job_page.dart';
import 'employer_posted_job_details.dart';
import 'employer_posted_jobs_page.dart';



class AddEditJobsPage extends StatefulWidget {
  @override
  State<AddEditJobsPage> createState() => _AddEditJobsPageState();
}

String empLogoImageUrl = "";
String? userEmail;

class _AddEditJobsPageState extends State<AddEditJobsPage> {
  @override
  void initState() {
    getEmpDetails();
    super.initState();
  }

  getEmpDetails() async {
    final userDataCache = await SharedPreferences.getInstance();

    userEmail = await userDataCache.getString("loggedInUserEmail")!;
    empLogoImageUrl =
        await userDataCache.getString('loggedInUserImageUrl') ?? kLogoImageUrl;
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
              builder: (context) => AddANewJobPage(
                  empLogoImageUrl: empLogoImageUrl, userEmail: userEmail),
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


