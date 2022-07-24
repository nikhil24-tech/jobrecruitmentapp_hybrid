import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../widgets/JobSeeker/editable_job_listing.dart';


class EmployerPostedJobsPage extends StatelessWidget {
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
              EditableJobListingWidget(),
              SizedBox(height: 15),
              EditableJobListingWidget(),
              SizedBox(height: 15),
              EditableJobListingWidget(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
