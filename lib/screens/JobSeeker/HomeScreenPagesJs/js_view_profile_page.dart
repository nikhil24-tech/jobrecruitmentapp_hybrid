import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../models/jk_user.dart';
import '../../../services/job_kart_db_service.dart';

class JSProfileDetailsPage extends StatefulWidget {
  final String? userEmail;
  JSProfileDetailsPage({required this.userEmail});

  @override
  State<JSProfileDetailsPage> createState() => _JSProfileDetailsPageState();
}

class _JSProfileDetailsPageState extends State<JSProfileDetailsPage> {
  JKUser jsDetails = JKUser(userType: "JobSeeker");

//Load the profile details from the database
  @override
  void initState() {
    getUserDetails();

    super.initState();
  }

  getUserDetails() async {
    jsDetails =
        await UserDBService.getJobSeekerProfile(email: widget.userEmail!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<JKUser>(
            future: UserDBService.getJobSeekerProfile(email: widget.userEmail!),
            builder: (context, jkUserSnapshot) {
              if (jkUserSnapshot.hasError) {
                return Text('Error: ${jkUserSnapshot.error}');
              } else if (jkUserSnapshot.hasData &&
                  jkUserSnapshot.data != null) {
                //show profile
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  width: double.maxFinite,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Align(
                            child: Text("JobKart", style: kSmallLogoTextStyle)),
                        SizedBox(height: 12),
                        Text("My Profile", style: kHeading2BoldStyle),
                        SizedBox(height: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: jkUserSnapshot.data!.jsImageUrl == null
                                      ? CircleAvatar(
                                          backgroundColor: Color(0xFFD9D9D9))
                                      : CircleAvatar(
                                          backgroundImage: Image.network(
                                                  jkUserSnapshot
                                                      .data!.jsImageUrl!)
                                              .image),
                                ),
                                SizedBox(width: 11),
                                Text(
                                    jkUserSnapshot.data!.jsName ??
                                        "Johnny Test",
                                    style: kGreyoutHeading4Style),
                              ],
                            ),
                            SizedBox(height: 12),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contact Details",
                                    style: kHeading2BoldStyle.copyWith(
                                        color: Color.fromRGBO(78, 77, 77, 1))),
                                SizedBox(height: 5),
                                Text("Mobile Phone",
                                    style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.jsPhone ??
                                        "+1 2453595555",
                                    style: kHeading3RegularStyle),
                                SizedBox(height: 12),
                                Text("Email Address",
                                    style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.email ??
                                        "Johnny@jobkart.com",
                                    style: kHeading3RegularStyle),
                                SizedBox(height: 12),
                                Text("Address", style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.jsAddress ??
                                        "New Avenue Montreal, \nCanada",
                                    style: kHeading3RegularStyle),
                                SizedBox(height: 15),
                                Text("About Me", style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.jsAboutMe ??
                                        "About me",
                                    style: kAppRegularTextStyle),
                                SizedBox(height: 15),
                                Text("Skills", style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.jsSkills ??
                                        "My Skills",
                                    style: kAppRegularTextStyle),
                                SizedBox(height: 15),
                                Text("Experience",
                                    style: kHeading2RegularStyle),
                                SizedBox(height: 5),
                                Text(
                                    jkUserSnapshot.data!.jsJobXp ??
                                        "My Experience",
                                    style: kAppRegularTextStyle),
                              ],
                            ),

                            SizedBox(height: 27),

                            //Click to update profile
                            ElevatedButton(
                              style: kBigButtonStyle,
                              child: Text("Update Profile"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ]),
                );
              } else if (jkUserSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                print("Unable to load data");
                return Center(
                    child: Text('Unable to load data',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)));
              }
            },
          ),
        ),
      ),
    );
  }
}
