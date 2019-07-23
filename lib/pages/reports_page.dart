
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
Map<String, double> dataMap = new Map();

@override
  void initState() {
    dataMap.putIfAbsent('Uncompleted', () => 3);
dataMap.putIfAbsent('In Progress', () => 3);
dataMap.putIfAbsent('completed', () => 8);
dataMap.putIfAbsent('Delayed', () => 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PieChart(dataMap: dataMap) 
        ],
      ),
    );
  }
}