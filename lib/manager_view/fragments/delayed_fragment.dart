import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasyl_attendence_app/pages/fragments/error_display_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Firestore _database = Firestore.instance;
final String task = 'Tasks';

class DelayedFragment extends StatefulWidget {
  final String employee;

  const DelayedFragment({Key key, this.employee}) : super(key: key);

  @override
  _DelayedFragmentState createState() => _DelayedFragmentState();
}

class _DelayedFragmentState extends State<DelayedFragment> {

  @override
  Widget build(BuildContext context) {
    String mUserId = widget.employee;
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: _database
              .collection(task)
              .where('user_id', isEqualTo: mUserId)
              .where('is_in_progress', isEqualTo: true)
              .where('end_time', isLessThan: Timestamp.now())
              .orderBy('end_time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorDisplayWidget();
            }
            if (!snapshot.hasData) {
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
                return ListView.separated(
                  itemCount:
                      tasks.documents.length == 0 ? 0 : tasks.documents.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    Map taskData = tasks.documents[index].data;
                    var date = taskData['timestamp'].toDate();
                    var formatter = DateFormat.yMMMMd("en_US").add_jm();
                    String formatted = formatter.format(date);
                    return ListTile(
                      title: Text('${taskData['title']}'),
                      subtitle: Text(formatted),
                    );
                  },
                );
            }
          }),
    );
  }
}
