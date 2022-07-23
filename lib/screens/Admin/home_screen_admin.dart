import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/style.dart';
import '../../widgets/JobSeeker/underlined_icon_widget.dart';
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int currentIndexOfBNB = 0; //BNB is Bottom Navigation Bar
  final List<Widget> _pages = [
    //AdminHomePage(),
    //AdminHomePage(),
    //AdminHomePage(),
    //AdminHomePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: _pages[currentIndexOfBNB],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
        color:Colors.transparent,
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
          boxShadow:[BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ]
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
                      iconData: FontAwesomeIcons.circleUser)
                      : Icon(FontAwesomeIcons.circleUser, size: 30),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: currentIndexOfBNB == 3
                      ? UnderlinedIconWidget(iconData: Icons.settings)
                      : Icon(Icons.settings, size: 30),
                  label: 'Settings',
                ),
              ]),
        ),
      ),

    );
  }
}
