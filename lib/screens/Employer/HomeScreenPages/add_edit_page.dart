import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import 'add_new_job_page.dart';



PageController _pageViewController = PageController(initialPage: 0);
class AddEditJobsPage extends StatefulWidget {
  @override
  State<AddEditJobsPage> createState() => _AddEditJobsPageState();
}

class _AddEditJobsPageState extends State<AddEditJobsPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(

      physics: NeverScrollableScrollPhysics(),
      controller: _pageViewController,
      children: [
        AddEditJobsWidget(),
        AddANewJobPage(),
      ],
    );
  }
}

class AddEditJobsWidget extends StatelessWidget {
  const AddEditJobsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('JobKart', style: kSmallLogoTextStyle),
        Spacer(),
        ElevatedButton(
          style: kBigButtonStyle,
          child: Text("Add A New Job"),
          onPressed: () {
            _pageViewController.animateToPage(
              1,
              duration: Duration(milliseconds: 10),
              curve: Curves.easeIn,
            );
          },
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: kBigButtonStyle,
          child: Text("Edit Jobs"),
          onPressed: () {
            _pageViewController.animateToPage(
              2,
              duration: Duration(milliseconds: 10),
              curve: Curves.easeIn,
            );
          },
        ),
        Spacer()
      ],
    );
  }
}
