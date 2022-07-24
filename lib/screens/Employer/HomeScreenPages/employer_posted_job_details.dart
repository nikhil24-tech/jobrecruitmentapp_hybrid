import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import 'posted_job_edit_page.dart';

class EmployerPostedJobDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23),
          width: double.maxFinite,
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 12),
            Align(child: Text("JobKart", style: kSmallLogoTextStyle)),
            SizedBox(height: 12),
            Text("Your Posted Jobs", style: kHeading2BoldStyle),
            SizedBox(height: 18),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xFFE2E1E1),
                  borderRadius: BorderRadius.circular(23)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Graphic Designer',
                              style: kHeading2BoldStyle.copyWith(
                                  color: Color(0xFF112E6F))),
                          SizedBox(height: 5),
                          Text('Real Estate Team', style: kHeading3DarkStyle),
                          SizedBox(height: 5),
                          Text('Montreal, Canada',
                              style: kAppTextDarkBoldStyle),
                          Chip(
                            label: Text('\$20-\$25 an hour',
                                style: kAppTextBoldWhiteStyle),
                            backgroundColor: kThemeColor1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/jobPicIcon.png',
                              height: 69, width: 63),
                        ],
                      ),
                    ],
                  ),
                  //Job Description
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Job Description", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: kAppRegularTextStyle),

                      SizedBox(height: 10),

                      //Job Requirements
                      Text("Requirements", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          style: kAppRegularTextStyle),
                      SizedBox(height: 10),

                      //Contact Information and Company Address
                      Text("Contact Information",
                          style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text("Email: Jobkart@test.com \nPhone: 1234567890",
                          style: kAppRegularTextStyle),
                      SizedBox(height: 10),
                      Text("Company Address", style: kHeading3DarkBoldStyle),
                      SizedBox(height: 10),
                      Text("1234, Monk H1WE3R \nMontreal, Canada",
                          style: kAppRegularTextStyle),
                    ],
                  ),
                  SizedBox(height: 10),

                  //Edit and Delete Job Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: kSmallButtonStyle.copyWith(
                            backgroundColor:
                            MaterialStateProperty.all(kDeleteRedColor)),
                        child: Text("Delete Job"),
                        onPressed: () {
                          //TODO:Implement Delete Job Functionality
                        },
                      ),
                      SizedBox(width: 17),
                      ElevatedButton(
                        style: kSmallButtonStyle,
                        child: Text("Edit Job"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostedJobEditPage()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
