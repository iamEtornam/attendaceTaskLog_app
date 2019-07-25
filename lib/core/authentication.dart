import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _database = Firestore.instance;
final String users = 'Users';
FirebaseUser currentUser;
ProgressDialog _progressDialog = ProgressDialog();

//login with email and pass method
Future emailPasswordLogin(
    BuildContext context, String email, String password) async {
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');

  try {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((response) {
      _progressDialog.dismissProgressDialog(context);
    }).catchError((error) {
      _progressDialog.dismissProgressDialog(context);
      alertNotification(context, Colors.red, 'Something went wrong.');
    });
  } catch (e) {
    debugPrint('error: $e');
  }
}

//get Logged in user role
getRole(BuildContext context) async {
  currentUser = await _auth.currentUser();
  _database
      .collection(users)
      .document(currentUser.uid)
      .get()
      .then((documentSnapshot) {
    if (documentSnapshot.data['role'] == 'employee') {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      Navigator.of(context).pushReplacementNamed('/managerView');
    }
  }).catchError((error) {});
}

//reset user password
processPasswordChange(BuildContext context) async {
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');
  FirebaseUser currentUser = await _auth.currentUser();
  _auth.sendPasswordResetEmail(email: currentUser.email).then((value) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(
        context, Colors.green, 'Reset Link sent. Check your mail.');
  }).catchError((error) {
    _progressDialog.dismissProgressDialog(context);
    alertNotification(context, Colors.red, 'Could not send link!');
  });
}

//log out current user
logout(BuildContext context) async {
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');
  currentUser = await _auth.currentUser();
  if (currentUser != null) {
    await _auth.signOut().then((_) {
      _progressDialog.dismissProgressDialog(context);
      Navigator.of(context).pushReplacementNamed('/login');
    }).catchError((error) {
      _progressDialog.dismissProgressDialog(context);
      alertNotification(context, Colors.red, 'Could not Log out!');
    });
  }
}
