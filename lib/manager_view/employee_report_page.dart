import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasyl_attendence_app/manager_view/fragments/completed_fragment.dart';
import 'package:fasyl_attendence_app/manager_view/fragments/delayed_fragment.dart';
import 'package:fasyl_attendence_app/manager_view/fragments/in_progress_fragment.dart';
import 'package:fasyl_attendence_app/manager_view/fragments/uncompleted_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Firestore _database = Firestore.instance;
final String users = 'Users';

class EmployeeReportPage extends StatefulWidget {
  final String employeeID;

  const EmployeeReportPage({Key key, this.employeeID}) : super(key: key);

  @override
  _EmployeeReportPageState createState() => _EmployeeReportPageState();
}

class _EmployeeReportPageState extends State<EmployeeReportPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Completed'),
    Tab(text: 'In-Progress'),
    Tab(text: 'Delayed'),
    Tab(text: 'Uncompleted'),
  ];

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabs.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<Object>(
            stream: _database
                .collection(users)
                .document(widget.employeeID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Not Avaliable');
              }

              if (!snapshot.hasData) {
                return Text('Not Avaliable');
              }

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Not Avaliable');
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                    ),
                  );
                  break;
                default:
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  return Text(
                    documentSnapshot.data == null
                        ? 'Loading...'
                        : '${documentSnapshot.data['name']}\'s Report',
                    style: TextStyle(fontSize: 20),
                  );
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Colors.black,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: tabs,
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  CompletedFragment(
                    employee: widget.employeeID,
                  ),
                  InProgressFragment(
                    employee: widget.employeeID,
                  ),
                  DelayedFragment(
                    employee: widget.employeeID,
                  ),
                  UncompletedFragment(
                    employee: widget.employeeID,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
