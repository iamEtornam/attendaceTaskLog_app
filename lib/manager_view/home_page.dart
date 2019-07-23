import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        centerTitle: true,
        title: Text('Fasyl Tech. (Manager)',style: TextStyle(fontSize: 20),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){

              },
                        child: CircleAvatar(
                radius: 20,
                backgroundColor: Platform.isIOS ? Colors.black : Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
              child: ListView.builder(
          itemCount: 70,
          itemBuilder: (context,index){
return InkWell(
  onTap: (){
    Navigator.of(context).pushNamed('/employeeReportView');
  },
  child:   Padding(
     padding: const EdgeInsets.fromLTRB(8,4,8,4),
    child: Row(
      children: <Widget>[
          Container(
            width: 5,
            height: 70, 
            child: SizedBox(),
            decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            ),
            Expanded(
                        child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(.05),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10,),
                Expanded(
                                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Full name $index',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    Text('Department $index')
                  ],
                  ),
                )
                  ],
                ),
              ),
            )
          
      ],
    ),
  ),
);
          },
        ),
      ),
    );
  }
}