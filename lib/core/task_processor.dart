import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _database = Firestore.instance;
final ProgressDialog _progressDialog = ProgressDialog();
FirebaseUser currentUser;
final String task = 'Tasks';

//add new task to database
saveNewTask(BuildContext context, String title, String description, startTime,
    endTime) async {
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');
  currentUser = await _auth.currentUser();
  _database.collection(task).document().setData({
    'title': title,
    'description': description,
    'start_time': startTime,
    'end_time': endTime,
    'is_completed': false,
    'is_in_progress': true,
    'timestamp': DateTime.now(),
    'user_id': currentUser.uid
  }).then((_) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(context, Colors.green, 'Task Saved!');
  }).then((_) {
     Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (Route<dynamic> route) => false,);

  }).catchError((error) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(context, Colors.red, 'Could not save Task!');
  });
}

//change completed state to true or false
changeCompletionState(
    BuildContext context, bool isCompleted, String taskID) async {
  _database
      .collection(task)
      .document(taskID)
      .updateData({'is_completed': isCompleted}).then((_) {
    alertNotification(context, Colors.green, 'Mark as Completed!');
  }).catchError((error) {
    alertNotification(context, Colors.red, 'Something went wrong');
  });
}

//delete task
deleteTask(BuildContext context, String taskID) async {
  _database.collection(task).document(taskID).delete().then((_) {
    alertNotification(context, Colors.green, 'Task Deleted!');
  }).catchError((error) {
    alertNotification(context, Colors.red, 'Could not delete Task');
  });
}

//edit single task
saveEditTask(BuildContext context, String title, String description, startTime,
    endTime, String taskID) async {
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');
  currentUser = await _auth.currentUser();
  _database.collection(task).document(taskID).setData({
    'title': title,
    'description': description,
    'start_time': startTime,
    'end_time': endTime,
    'timestamp': DateTime.now(),
  }, merge: true).then((_) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(context, Colors.green, 'Editted Task Saved!');
  }).then((_) {
     Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (Route<dynamic> route) => false,);
  }).catchError((error) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(context, Colors.red, 'Could not save Editted Task!');
  });
}
