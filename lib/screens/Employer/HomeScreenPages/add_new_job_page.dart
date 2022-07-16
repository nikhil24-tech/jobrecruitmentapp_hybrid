import 'package:flutter/material.dart';
import '../../../constants/style.dart';

class AddANewJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                SizedBox(height: 12),
                Text("JobKart", style: kSmallLogoTextStyle),
                SizedBox(height: 33),
                Text("Add a New Job", style: kGreyoutHeading3Style),
                SizedBox(height: 50),
                TextField(
                    decoration:
                    kTextFieldInputDecoration.copyWith(labelText: "Job Name")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Organisation Address")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Contact Email")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Organisation Type")),
                SizedBox(height: 12),
                TextField(
                    decoration:
                    kTextFieldInputDecoration.copyWith(labelText: "Salary")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Job Description")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Requirements")),
                SizedBox(height: 80),
                ElevatedButton(
                  style: kBigButtonStyle,
                  child: Text("Add A New Job"),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
