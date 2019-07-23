import 'package:flutter/material.dart';

class CompletedFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 50,
        separatorBuilder: (context,index){
          return Divider();
        },
        itemBuilder: (context,index){
          return ListTile(
            title: Text('Ttile $index'),
            subtitle: Text('subtitle $index'),
          );
        },
      ),
    );
  }
}