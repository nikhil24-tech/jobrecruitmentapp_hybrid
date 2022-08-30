import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../models/jk_user.dart';
import '../../../widgets/Admin/admin_emp_summary_widget.dart';
import '../../../widgets/Admin/admin_js_summary_widget.dart';

class UserProileAdminPage extends StatefulWidget {
  @override
  State<UserProileAdminPage> createState() => _UserProileAdminPageState();
}

var dropDownSelection = "employer";

class _UserProileAdminPageState extends State<UserProileAdminPage> {
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
            child: Text('User Profiles', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 20),

          //create a dropdown menu to filter user type
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: kThemeColor1,
              ),
              child: DropdownButton(
                style: kAppTextBoldWhiteStyle,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                dropdownColor: kThemeColor1,
                underline: Container(),
                value: dropDownSelection,
                items: [
                  DropdownMenuItem(
                    child: Text("Recruiter"),
                    value: "employer",
                  ),
                  DropdownMenuItem(
                    child: Text("Job Seeker"),
                    value: "jobseeker",
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownSelection = newValue!;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot<Map>>(
              stream:
              FirebaseFirestore.instance.collection('jk_users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final List<JKUser> allUsers = snapshot.data!.docs
                      .map((doc) => JKUser.fromDocument(doc))
                      .where((user) => user.userType == dropDownSelection)
                      .toList();

                  //Build a list view of jobs posted by employer
                  return JKUserProfilesView(allUsers: allUsers);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print("snapshot doesn't have data");
                  return Center(
                      child: Text('No Users',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)));
                }
              }),
        ],
      ),
    );
  }
}

class JKUserProfilesView extends StatelessWidget {
  final List<JKUser> allUsers;
  const JKUserProfilesView({required List<JKUser> this.allUsers});

  @override
  Widget build(BuildContext context) {
    return allUsers.length == 0
        ? Center(child: Text('No Users', style: kHeading2BoldStyle))
        : Flexible(
      child: ListView.builder(
        itemCount: allUsers.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              allUsers[index].userType == "employer"
                  ? AdminEmpSummaryWidget(empUser: allUsers[index])
                  : AdminJSSummaryWidget(jsUser: allUsers[index]),
              SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }
}
