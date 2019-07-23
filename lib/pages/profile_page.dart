import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
   final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordConfirmController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child: CircleAvatar(
                radius: 60,
              )
              ),
          SizedBox(
            height: 30.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: _nameController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enableInteractiveSelection: true,
                    focusNode: _nameFocusNode,
                      enabled: false,
                    decoration: InputDecoration(
                      enabled: false,
                      hasFloatingPlaceholder: true,
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                      enabled: false,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    focusNode: _phoneFocusNode,
                    controller: _phoneController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                      enabled: false,

                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
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
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
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
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    focusNode: _passwordConfirmFocusNode,
                    controller: _passwordConfirmController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black),
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
      ),
    );
  }
}