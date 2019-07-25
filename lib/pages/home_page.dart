import 'dart:io';
import 'dart:math';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasyl_attendence_app/core/task_processor.dart';
import 'package:fasyl_attendence_app/pages/edit_task_page.dart';
import 'package:fasyl_attendence_app/pages/fragments/error_display_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _database = Firestore.instance;
final String task = 'Tasks';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCompleted = false;
  bool _isVisible = true;
  ScrollController _scrollController;
  FirebaseUser currentUser;
  String mUserId;

  getCurrentUser() async {
    currentUser = await _auth.currentUser();
    setState(() {
      mUserId = currentUser.uid;
    });
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mUserId == null
          ? ErrorDisplayWidget()
          : StreamBuilder<Object>(
              stream: _database
                  .collection(task)
                  .where('user_id', isEqualTo: mUserId)
                  .where('is_completed', isEqualTo: false)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorDisplayWidget();
                }

                if(snapshot.hasData == false){
                  return ErrorDisplayWidget();
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return ErrorDisplayWidget();
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
                    QuerySnapshot tasks = snapshot.data;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: tasks.documents.length == 0
                          ? 0
                          : tasks.documents.length,
                      itemBuilder: (context, index) {
                        Map taskData = tasks.documents[index].data;
                        String taskId = tasks.documents[index].documentID;

                        var date = taskData['timestamp'].toDate();
                        var formatter = DateFormat.yMMMMd("en_US").add_jm();
                        String formatted = formatter.format(date);


                        return Slidable(
                          actionPane: Platform.isIOS
                              ? SlidableStrechActionPane()
                              : SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 5,
                                  height: 80,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8)),
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CircularCheckBox(
                                            value: taskData['is_completed'],
                                            materialTapTargetSize:
                                                MaterialTapTargetSize.padded,
                                            onChanged: (bool x) async {
                                              await changeCompletionState(
                                                  context, x, taskId);
                                            }),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '${taskData['title']}',
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(formatted),
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
                              onTap: () async {
                                await editTask(tasks.documents[index]);
                              },
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: AntDesign.getIconData('delete'),
                              onTap: () async {
                                await deleteTask(context, taskId);
                              },
                            ),
                          ],
                        );
                      },
                    );
                }
              }),
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

  //pass data to editTaskPage
  editTask(DocumentSnapshot document) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditTaskPage(
                  taskSnapshot: document,
                )));
  }
}
