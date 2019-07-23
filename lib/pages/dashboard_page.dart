import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:fasyl_attendence_app/pages/home_page.dart';
import 'package:fasyl_attendence_app/pages/profile_page.dart';
import 'package:fasyl_attendence_app/pages/reports_page.dart';
import 'package:fasyl_attendence_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

    final List<Widget> _pages = [
    HomePage(),
    ReportsPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void changePage(int index) {
     setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fasyl Attendance',style: TextStyle(fontSize: 20),),
      ),
      body: SafeArea(
              child: Center(
                child: _pages[currentIndex],
              ),
      ),
     bottomNavigationBar: BubbleBottomBar(
       backgroundColor: Platform.isIOS ? Colors.white : Colors.black,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: Platform.isIOS ? 0 : 4,
        hasInk: true,
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Platform.isIOS ? Colors.black : Colors.white,
              icon: Icon(
                Feather.getIconData('home'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              activeIcon: Icon(
                Feather.getIconData('home'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              title: Text("Home",style: TextStyle(color: Platform.isIOS ? Colors.black : Colors.white),)),
          BubbleBottomBarItem(
              backgroundColor: Platform.isIOS ? Colors.black : Platform.isIOS ? Colors.black : Colors.white,
              icon: Icon(
                Feather.getIconData('pie-chart'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              activeIcon: Icon(
                Feather.getIconData('pie-chart'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              title: Text("Reports")),
          BubbleBottomBarItem(
              backgroundColor: Platform.isIOS ? Colors.black : Colors.white,
              icon: Icon(
                Octicons.getIconData('person'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              activeIcon: Icon(
                Octicons.getIconData('person'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              title: Text("Profile")),
          BubbleBottomBarItem(
              backgroundColor: Platform.isIOS ? Colors.black : Colors.white,
              icon: Icon(
                Octicons.getIconData('settings'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              activeIcon: Icon(
                Octicons.getIconData('settings'),
                color: Platform.isIOS ? Colors.black : Colors.white,
              ),
              title: Text("Settings")),
        ],
      ),
    );
  }
}