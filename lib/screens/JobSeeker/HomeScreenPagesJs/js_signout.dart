import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../user_type_select.dart';

class JSSignout extends StatelessWidget {
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
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserTypeSelectScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
