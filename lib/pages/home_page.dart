import 'dart:io';
import 'dart:math';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 bool isCompleted = false;
  bool _isVisible = true;
   ScrollController _scrollController;

@override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
            setState((){
              _isVisible = false;
            });
        }
      } else {
        if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
               setState((){
                 _isVisible = true;
               });
           }
        }
    }});
  }

    @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (context,index){
return Slidable(
  actionPane: Platform.isIOS ? SlidableStrechActionPane() : SlidableDrawerActionPane(),
  actionExtentRatio: 0.25,
  child: Padding(
     padding: const EdgeInsets.fromLTRB(8,4,8,4),
    child: Row(
      children: <Widget>[
        Container(
          width: 5,
          height: 80, 
          child: SizedBox(),
          decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          ),
          Expanded(
                      child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularCheckBox(
              value: isCompleted,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (bool x) {
              setState(() {
                isCompleted = x;
              });
              }
              ),
              SizedBox(width: 10,),
              Expanded(
                              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('tile here $index',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  SizedBox(height: 8,),
                  Text('subtitle here $index')
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
  actions: <Widget>[
    IconSlideAction(
      caption: 'Edit',
      color: Colors.blue,
      icon: AntDesign.getIconData('edit'),
      onTap: () {},
    ),
  ],
  secondaryActions: <Widget>[
    IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: AntDesign.getIconData('delete'),
      onTap: () {},
    ),
  ],
);
        },
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
              child: FloatingActionButton.extended(
          onPressed: () {
     Navigator.of(context).pushNamed('/addTask');
          },
          icon: Icon(
            AntDesign.getIconData('addfile'),
            color: Colors.black,
          ),
          label: Text('Add Task'),
          backgroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}