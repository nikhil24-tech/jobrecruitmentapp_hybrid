import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../constants/style.dart';
import '../../../models/jk_user.dart';
import '../../../services/job_kart_db_service.dart';

class JSProfileAdminView extends StatefulWidget {
  final JKUser jsUser;
  JSProfileAdminView({required this.jsUser});

  @override
  State<JSProfileAdminView> createState() => _JSProfileAdminViewState();
}

class _JSProfileAdminViewState extends State<JSProfileAdminView> {
  bool isuserBlocked = false;

  @override
  void initState() {
    updateIsUserBlocked();
    super.initState();
  }

  updateIsUserBlocked() async {
    isuserBlocked =
    (await UserDBService.getIsBlocked(email: widget.jsUser.email!))!;
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
                    Text("Job Seeker", style: kHeading2BoldStyle),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 66,
                          width: 66,
                          child: widget.jsUser.jsImageUrl == null
                              ? CircleAvatar(backgroundColor: Color(0xFFD9D9D9))
                              : CircleAvatar(
                              backgroundImage:
                              Image.network(widget.jsUser.jsImageUrl!)
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
                            Text(widget.jsUser.jsName ?? "Johnny Test",
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
                        Text(widget.jsUser.jsPhone ?? "+1 2453595555",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Email Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(widget.jsUser.email ?? "Johnny@jobkart.com",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 12),
                        Text("Address", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(
                            widget.jsUser.jsLocation ??
                                "New Avenue Montreal, \nCanada",
                            style: kHeading3RegularStyle),
                        SizedBox(height: 15),
                        Text("About Me", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(
                            widget.jsUser.jsAboutMe ??
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 15),
                        Text("Skills", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(
                            widget.jsUser.jsSkills ??
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
                            style: kAppRegularTextStyle),
                        SizedBox(height: 15),
                        Text("Experience", style: kHeading2RegularStyle),
                        SizedBox(height: 5),
                        Text(
                            widget.jsUser.jsJobXp ??
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum.",
                            style: kAppRegularTextStyle),
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
                            email: widget.jsUser.email!);
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
                            email: widget.jsUser.email!);
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
