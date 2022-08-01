import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../user_type_select.dart';

class AdminSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 33),
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 13),
              Text("JobKart", style: kSmallLogoTextStyle),
              SizedBox(height: 37),
              ElevatedButton(
                style: kBigButtonStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all(kDeleteRedColor),
                ),
                child: Text("Sign Out"),
                onPressed: () {
                  //TODO: Implement Signout Logic

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserTypeSelectScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
