import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fasyl_attendence_app/pages/fragments/completed_fragment.dart';
import 'package:fasyl_attendence_app/pages/fragments/delayed_fragment.dart';
import 'package:fasyl_attendence_app/pages/fragments/in_progress_fragment.dart';
import 'package:fasyl_attendence_app/pages/fragments/uncompleted_fragment.dart';
import 'package:flutter/material.dart';

class EmployeeReportPage extends StatefulWidget {
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
        title: Text(
          'Employee Report',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Employee Name here',
              style: TextStyle(fontSize: 20),
            ),
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
                  CompletedFragment(),
                  InProgressFragment(),
                  DelayedFragment(),
                  UncompletedFragment(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
