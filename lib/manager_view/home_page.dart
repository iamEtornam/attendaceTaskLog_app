import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasyl_attendence_app/manager_view/employee_report_page.dart';
import 'package:fasyl_attendence_app/pages/fragments/error_display_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _database = Firestore.instance;
final String users = 'Users';
final String teams = 'teams';
FirebaseUser currentUser;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mUserId;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    currentUser = await _auth.currentUser();
    setState(() {
      mUserId = currentUser.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Attendance-Task (Manager)',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          mUserId == null
              ? Container()
              : StreamBuilder<Object>(
                  stream:
                      _database.collection(users).document(mUserId).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Icon(
                        Icons.error,
                        color: Colors.white,
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Icon(
                          Icons.error,
                          color: Colors.white,
                        );
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
                        DocumentSnapshot userData = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/managerProfile');
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Platform.isIOS ? Colors.black : Colors.white,
                              backgroundImage:
                                  NetworkImage(userData.data['photo']),
                            ),
                          ),
                        );
                    }
                  })
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<Object>(
            stream: _database
                .collection(users)
                .document(mUserId)
                .collection(teams)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              QuerySnapshot querySnapshot = snapshot.data;
              if (snapshot.hasError) {
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
                  return ListView.builder(
                    itemCount: querySnapshot.documents.length == 0
                        ? 0
                        : querySnapshot.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          querySnapshot.documents[0];
                      String documentId = documentSnapshot.documentID;
                      debugPrint('data: ${documentSnapshot.documentID}');

                      return StreamBuilder<Object>(
                          stream: _database
                              .collection(users)
                              .document(documentId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
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
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data;
//                                debugPrint(
//                                    'user data: ${documentSnapshot.documentID}');
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/employeeReportView');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmployeeReportPage(
                                                  employeeID: documentSnapshot
                                                      .documentID,
                                                )));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 5,
                                          height: 70,
                                          child: SizedBox(),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(8)),
                                            color: Colors.primaries[Random()
                                                .nextInt(
                                                    Colors.primaries.length)],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color:
                                                Colors.black.withOpacity(.05),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.black,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            documentSnapshot
                                                                .data['photo']),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        '${documentSnapshot.data['name']}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                          '${documentSnapshot.data['department']}')
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
                            }
                          });
                    },
                  );
              }
            }),
      ),
    );
  }
}
