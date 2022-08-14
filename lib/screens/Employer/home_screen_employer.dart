import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobrecruitmentapp_hybrid/screens/Employer/HomeScreenPages/search_page.dart';
import '../../constants/style.dart';
import '../../widgets/exit_confirmation_dialog.dart';
import '../../widgets/underlined_icon_widget.dart';
import '../user_type_select.dart';
import 'HomeScreenPages/add_edit_page.dart';

import 'HomeScreenPages/jobs_page.dart';
import 'HomeScreenPages/settings_page.dart';


class EmployerHomeScreen extends StatefulWidget {
  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  int currentIndexOfBNB = 0; //BNB is Bottom Navigation Bar
  final List<Widget> _pages = [
    Center(child: jobsPage()),
    Center(child: SearchPage()),
    Center(child: AddEditJobsPage()),
    Center(child: jobsPage()),
    Center(child: SettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await exitConfirmationDialog(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: SafeArea(
          child: _pages[currentIndexOfBNB],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            //backgroundBlendMode: BlendMode.clear,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndexOfBNB,
                onTap: (index) => setState(() {
                  currentIndexOfBNB = index;
                }),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: kThemeColor1,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 0
                        ? UnderlinedIconWidget(iconData: Icons.home)
                        : Icon(Icons.home, size: 30),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 1
                        ? UnderlinedIconWidget(iconData: Icons.search)
                        : Icon(Icons.search, size: 30),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 2
                        ? UnderlinedIconWidget(
                        iconData: FontAwesomeIcons.circlePlus)
                        : Icon(FontAwesomeIcons.circlePlus, size: 30),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 3
                        ? UnderlinedIconWidget(
                        iconData: FontAwesomeIcons.circleUser)
                        : Icon(FontAwesomeIcons.circleUser, size: 30),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 4
                        ? UnderlinedIconWidget(iconData: Icons.settings)
                        : Icon(Icons.settings, size: 30),
                    label: 'Settings',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
