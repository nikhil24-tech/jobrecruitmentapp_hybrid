import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../models/jk_user.dart';
import '../../screens/Admin/HomeScreenPagesAdmin/emp_profile_admin_view.dart';

class AdminEmpSummaryWidget extends StatelessWidget {
  final JKUser empUser;
  const AdminEmpSummaryWidget({required this.empUser});

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
                child: empUser.orgImageUrl != null
                    ? CircleAvatar(
                        backgroundImage:
                            Image.network(empUser.orgImageUrl!).image,
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
                      "Name: ${empUser.empName!.length > 18 ? (empUser.empName!.substring(0, 15)) + '...' : empUser.empName!}",
                      style: kHeading2BoldStyle),
                  SizedBox(height: 5),
                  Text(empUser.empPhone ?? "phone", style: kHeading3DarkStyle),
                  SizedBox(height: 5),
                  Text(empUser.orgLocation ?? "address",
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
                //TODO: Implement Navigate to User Details Page

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmpProfileAdminView(empUser: empUser),
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
