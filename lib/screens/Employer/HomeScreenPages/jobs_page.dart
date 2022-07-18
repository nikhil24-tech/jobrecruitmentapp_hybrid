import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../widgets/job_listing_widget.dart';

class jobsPage extends StatelessWidget {
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
          JobListingWidget(),
          SizedBox(height: 12),
          JobListingWidget(),
          SizedBox(height: 12),
          JobListingWidget(),
        ],
      ),
    );
  }
}
