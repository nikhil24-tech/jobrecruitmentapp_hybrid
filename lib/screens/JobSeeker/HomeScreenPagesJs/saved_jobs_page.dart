import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../widgets/JobSeeker/js_job_listing_widget.dart';
import '../../../widgets/JobSeeker/saved_jobs_widget.dart';

class SavedJobsPage extends StatelessWidget {
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
            child: Text('Saved Jobs', style: kHeading2BoldStyle),
          ),
          SizedBox(height: 12),
          SavedJobWidget(),
          SizedBox(height: 12),
          SavedJobWidget(),
          SizedBox(height: 12),
          SavedJobWidget(),
        ],
      ),
    );
  }
}
