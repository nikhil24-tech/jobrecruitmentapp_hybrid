import 'package:flutter/material.dart';
import '../../constants/style.dart';

import '../../widgets/exit_confirmation_dialog.dart';

import '../../widgets/underlined_icon_widget.dart';
import 'HomeScreenPagesJs/applied_jobs_page.dart';
import 'HomeScreenPagesJs/js_home_page.dart';
import 'HomeScreenPagesJs/js_search_page.dart';
import 'HomeScreenPagesJs/js_settings_page.dart';
import 'HomeScreenPagesJs/saved_jobs_page.dart';

class JobSeekerHomeScreen extends StatefulWidget {
  @override
  State<JobSeekerHomeScreen> createState() => _JobSeekerHomeScreenState();
}

class _JobSeekerHomeScreenState extends State<JobSeekerHomeScreen> {
  int currentIndexOfBNB = 0; //BNB is Bottom Navigation Bar
  final List<Widget> _pages = [
    JobSeekerHomePage(),
    JobSeekerSearchPage(),
    AppliedJobsPage(),
    SavedJobsPage(),
    JobSeekerSettingsPage(),
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
                        ? UnderlinedIconWidget(iconData: Icons.check_circle)
                        : Icon(Icons.check_circle, size: 30),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: currentIndexOfBNB == 3
                        ? UnderlinedIconWidget(iconData: Icons.bookmark)
                        : Icon(Icons.bookmark, size: 30),
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
