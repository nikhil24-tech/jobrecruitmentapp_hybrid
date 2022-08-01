import 'package:flutter/material.dart';
import '../../../constants/style.dart';

class PostedJobEditPage extends StatelessWidget {
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Edit Job", style: kGreyoutHeading3Style)),
                SizedBox(height: 40),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Real Estate Team")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "1234, Monk H1WE3R Montreal, Cana")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "jobkart@test.com")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "Real Estate")),
                SizedBox(height: 12),
                TextField(
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: "\$ 20-25")),
                SizedBox(height: 12),
                TextField(
                    maxLines: 4,
                    decoration: kTextFieldInputDecorationMultiLine.copyWith(
                      labelText:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                    )),
                SizedBox(height: 12),
                TextField(
                    maxLines: 4,
                    decoration: kTextFieldInputDecorationMultiLine.copyWith(
                        labelText:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make.")),
                SizedBox(height: 18),
                ElevatedButton(
                  style: kBigButtonStyle,
                  child: Text("Save Edit Job"),
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
