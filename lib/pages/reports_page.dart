
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fasyl_attendence_app/pages/fragments/completed_fragment.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin{
Map<String, double> dataMap = new Map();
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

    dataMap.putIfAbsent('Uncompleted', () => 3);
dataMap.putIfAbsent('In-Progress', () => 3);
dataMap.putIfAbsent('Completed', () => 8);
dataMap.putIfAbsent('Delayed', () => 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            PieChart(dataMap: dataMap) ,
            SizedBox(height: 15,),
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
                CompletedFragment(),
                CompletedFragment(),
                CompletedFragment(),

              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}