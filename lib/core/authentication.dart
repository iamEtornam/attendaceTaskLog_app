import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
ProgressDialog _progressDialog = ProgressDialog();

//login with email and pass method
Future emailPasswordLogin(BuildContext context, String email, String password) async{
  _progressDialog.showProgressDialog(context,
      textToBeDisplayed: 'Please wait...');

  try{
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((response){
      _progressDialog.dismissProgressDialog(context);
    }).catchError((error){
      _progressDialog.dismissProgressDialog(context);
      alertNotification(context, Colors.red, 'Something went wrong.');
    });
  }catch(e){
debugPrint('error: $e');
  }
}