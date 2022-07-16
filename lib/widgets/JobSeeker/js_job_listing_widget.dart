import 'package:flutter/material.dart';
import '../../constants/style.dart';

class JobSeekerJobListingWidget extends StatelessWidget {
//A Row inside a container with two columns in it. The first column
  //containing three text widgets and a chip .The second column
  //containing an icon and a button

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  child: Text("Apply Job"),
                  onPressed: () {},
                ),
                SizedBox(height: 17),
                ElevatedButton(
                  style: kSmallButtonStyle,
                  child: Text("Save Job"),
                  onPressed: () {
                    //TODO: Implement Save job functionality
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