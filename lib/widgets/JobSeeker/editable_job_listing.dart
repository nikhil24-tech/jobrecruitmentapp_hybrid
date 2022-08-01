import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../screens/Employer/HomeScreenPages/employer_posted_job_details.dart';
import '../../screens/Employer/HomeScreenPages/posted_job_edit_page.dart';


class EditableJobListingWidget extends StatelessWidget {
//A Row inside a contaiber with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployerPostedJobDetailsPage()));
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xAAE2E1E1),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Graphic Designer',
                    style:
                    kHeading2BoldStyle.copyWith(color: Color(0xFF112E6F))),
                SizedBox(height: 5),
                Text(
                  'Real Estate Team',
                  style: kHeading3DarkStyle,
                ),
                SizedBox(height: 5),
                Text('Montreal, Canada', style: kAppTextDarkBoldStyle),
                Chip(
                  label:
                  Text('\$20-\$25 an hour', style: kAppTextBoldWhiteStyle),
                  backgroundColor: kThemeColor1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: kSmallButtonStyle,
                  child: Text("Edit Job"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PostedJobEditPage())));
                  },
                ),
                SizedBox(height: 17),
                ElevatedButton(
                  style: kSmallButtonStyle.copyWith(
                      backgroundColor:
                      MaterialStateProperty.all(kDeleteRedColor)),
                  child: Text("Delete Job"),
                  onPressed: () {
                    //TODO: Implement delete job functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
