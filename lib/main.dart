import 'dart:io';

import 'package:fasyl_attendence_app/manager_view/employee_report_page.dart';
import 'package:fasyl_attendence_app/manager_view/home_page.dart';
import 'package:fasyl_attendence_app/pages/add_task_page.dart';
import 'package:fasyl_attendence_app/pages/dashboard_page.dart';
import 'package:fasyl_attendence_app/pages/edit_task_page.dart';
import 'package:fasyl_attendence_app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fasyl Attendance',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        primaryColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.black),
        accentColor: Colors.black,
        accentColorBrightness: Brightness.dark,
        primaryIconTheme: IconThemeData(color: Colors.black),
        indicatorColor: Colors.black,
             fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
              color: Platform.isIOS ? Colors.white : Colors.black,
              elevation: Platform.isIOS ? 0 : 4,
              actionsIconTheme: IconThemeData(color: Platform.isIOS ? Colors.black : Colors.white),
              iconTheme: IconThemeData(color: Platform.isIOS ? Colors.black : Colors.white),
              textTheme: TextTheme(
                  title: TextStyle(
                color: Platform.isIOS ? Colors.black : Colors.white,
              ))),
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/dashboard': (BuildContext context) => DashboardPage(),
        '/addTask':(BuildContext context)=>AddTaskPage(),
        '/managerView':(BuildContext context)=>HomePage(),
        '/employeeReportView':(BuildContext context)=>EmployeeReportPage(),
        '/editTask':(BuildContext context)=>EditTaskPage(),

      },
    );
  }
}
