import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasyl_attendence_app/core/authentication.dart';
import 'package:fasyl_attendence_app/pages/fragments/error_display_widget.dart';
import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _database = Firestore.instance;
final String users = 'Users';

class ManagerProfilePage extends StatefulWidget {
  @override
  _ManagerProfilePageState createState() => _ManagerProfilePageState();
}

class _ManagerProfilePageState extends State<ManagerProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _departmentController = TextEditingController();
  FirebaseUser currentUser;
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
          'Profile',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: mUserId == null
          ? Container()
          : StreamBuilder<DocumentSnapshot>(
              stream: _database.collection(users).document(mUserId).snapshots(),
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
                    _nameController.text = snapshot.data.data['name'];
                    _phoneController.text = snapshot.data.data['phone'];
                    _emailController.text = snapshot.data.data['email'];
                    _departmentController.text =
                        snapshot.data.data['department'];
                    return ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(snapshot.data.data['photo']),
                        )),
                        SizedBox(
                          height: 30.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  enableInteractiveSelection: true,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    enabled: false,
                                    hasFloatingPlaceholder: true,
                                    hintText: 'Full Name',
                                    hintStyle: TextStyle(color: Colors.black45),
                                    contentPadding: EdgeInsets.all(15.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        TextStyle(color: Colors.black45),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Full Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  readOnly: true,
                                  enableInteractiveSelection: true,
                                  decoration: InputDecoration(
                                    hasFloatingPlaceholder: true,
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(color: Colors.black45),
                                    contentPadding: EdgeInsets.all(15.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        TextStyle(color: Colors.black45),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Email Address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: TextFormField(
                                  controller: _phoneController,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  readOnly: true,
                                  enableInteractiveSelection: true,
                                  decoration: InputDecoration(
                                    hasFloatingPlaceholder: true,
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(color: Colors.black45),
                                    contentPadding: EdgeInsets.all(15.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        TextStyle(color: Colors.black45),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Phone Number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: TextFormField(
                                  controller: _departmentController,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  enableInteractiveSelection: true,
                                  decoration: InputDecoration(
                                    hasFloatingPlaceholder: true,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.black45),
                                    contentPadding: EdgeInsets.all(15.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        TextStyle(color: Colors.black45),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Material(
                            type: MaterialType.button,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 2,
                              height: 45.0,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  showPlatformDialog(
                                    context: context,
                                    builder: (_) => PlatformAlertDialog(
                                      content: Text(
                                          'Are you sure you want reset your Password?'),
                                      actions: <Widget>[
                                        PlatformDialogAction(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            changeUserPassword(context);
                                          },
                                        ),
                                        PlatformDialogAction(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  alertNotification(context, Colors.red,
                                      'Something went wrong.');
                                }
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    );
                }
              }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          type: MaterialType.button,
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 45.0,
            onPressed: () async {
              showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                  content: Text('Are you sure you want to Log out?'),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: Text('Yes'),
                      onPressed: () async {
                        await logout(context);
                      },
                    ),
                    PlatformDialogAction(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void changeUserPassword(BuildContext context) async {
    await processPasswordChange(context);
  }
}
