import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../models/jk_user.dart';
import '../../screens/Admin/HomeScreenPagesAdmin/js_profile_admin_view.dart';

class AdminJSSummaryWidget extends StatelessWidget {
  final JKUser jsUser;
  const AdminJSSummaryWidget({required this.jsUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      decoration: BoxDecoration(
        color: kContainerBackgroundColor,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 66,
                width: 66,
                child: jsUser.jsImageUrl != null
                    ? CircleAvatar(
                        backgroundImage:
                            Image.network(jsUser.jsImageUrl!).image,
                      )
                    : CircleAvatar(
                        backgroundColor: Color(0xFFD9D9D9),
                      ),
              ),
              SizedBox(width: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Name: ${jsUser.jsName!.length > 18 ? (jsUser.jsName!.substring(0, 15)) + '...' : jsUser.jsName!}",
                      style: kHeading2BoldStyle),
                  SizedBox(height: 5),
                  Text(jsUser.jsPhone ?? "phone", style: kHeading3DarkStyle),
                  SizedBox(height: 5),
                  Text(jsUser.jsLocation ?? "address",
                      style: kAppTextDarkBoldStyle),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: kSmallButtonStyle.copyWith(
                  fixedSize: MaterialStateProperty.all(Size(110, 40))),
              child: Text("View"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JSProfileAdminView(jsUser: jsUser),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
