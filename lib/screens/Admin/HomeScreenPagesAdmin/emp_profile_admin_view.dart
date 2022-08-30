import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../constants/style.dart';
import '../../../models/jk_user.dart';
import '../../../services/job_kart_db_service.dart';

class EmpProfileAdminView extends StatefulWidget {
  final JKUser empUser;
  EmpProfileAdminView({required this.empUser});

  @override
  State<EmpProfileAdminView> createState() => _EmpProfileAdminViewState();
}

class _EmpProfileAdminViewState extends State<EmpProfileAdminView> {
  bool isuserBlocked = false;

  @override
  void initState() {
    updateIsUserBlocked();
    super.initState();
  }

  updateIsUserBlocked() async {
    isuserBlocked =
    (await UserDBService.getIsBlocked(email: widget.empUser.email!))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              width: double.maxFinite,
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 12),
                Align(child: Text("JobKart", style: kSmallLogoTextStyle)),
                SizedBox(height: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recruiter", style: kHeading2BoldStyle),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 66,
                          width: 66,
                          child: widget.empUser.orgImageUrl == null
                              ? CircleAvatar(backgroundColor: Color(0xFFD9D9D9))
                              : CircleAvatar(
                              backgroundImage:
                              Image.network(widget.empUser.orgImageUrl!)
                                  .image),
                        ),
                        SizedBox(width: 11),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name",
                                style: kHeading2BoldStyle.copyWith(
                                    color: Color.fromRGBO(78, 77, 77, 1))),
                            SizedBox(height: 5),
                            Text(widget.empUser.empName ?? "Johnny Test",
                                style: kGreyoutHeading4Style),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Details",
                            style: kHeading2BoldStyle.copyWith(
                                color: Color.fromRGBO(78, 77, 77, 1))),
                        SizedBox(height: 5),
                        Text("Mobile Phone", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.empUser.empPhone ?? "+1 2453595555",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Email Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.empUser.email ?? "Johnny@jobkart.com",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(
                            widget.empUser.orgLocation ??
                                "New Avenue Montreal, \nCanada",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 15),
                        Text("Org Type", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.empUser.orgType ?? "organisationType",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 27),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          fixedSize: Size(138, 39),
                          textStyle: kSmallButtonTextStyle,
                          primary: kDeleteRedColor),
                      child: Text("Block"),
                      onPressed: isuserBlocked == true
                          ? null
                          : () async {
                        await UserDBService.blockUser(
                            email: widget.empUser.email!);
                        setState(() {
                          isuserBlocked = true;
                        });
                        MotionToast.info(
                            description: Text("User Blocked",
                                style: kBigButtonTextStyle))
                            .show(context);
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: kSmallButtonStyle,
                      child: Text("Unblock"),
                      onPressed: isuserBlocked == false
                          ? null
                          : () async {
                        await UserDBService.UnBlockUser(
                            email: widget.empUser.email!);
                        setState(() {
                          isuserBlocked = false;
                        });
                        MotionToast.info(
                            description: Text("User Unblocked",
                                style: kBigButtonTextStyle))
                            .show(context);
                      },
                    )
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
