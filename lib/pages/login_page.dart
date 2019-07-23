import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State < LoginPage > {
  final _formKey = GlobalKey < FormState > ();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  bool isObscured = true;
  IconData isVisibleIcon = Icons.visibility;

  void makeVisible() async {
    if (isObscured) {
      setState(() {
        isObscured = false;
        isVisibleIcon = Icons.visibility_off;
      });
    } else {
      setState(() {
        isObscured = true;
        isVisibleIcon = Icons.visibility;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                children: < Widget > [
                  FlutterLogo(
                    size: 80,
                    colors: Colors.blueGrey,
                  ),
                  SizedBox(height: 10, ),
                  Center(child: Text('Fasyl Technologies', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500), )),
                  SizedBox(height: 100),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: < Widget > [
                        TextFormField(
                          focusNode: _emailFocusNode,
                          controller: _emailController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Entypo.getIconData('email')),
                            hasFloatingPlaceholder: true,
                            hintText: 'Email',
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
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10, ),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          cursorColor: Colors.black,
                          obscureText: isObscured,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Feather.getIconData('lock')),
                            suffixIcon: InkWell(
                              onTap: () {
                                makeVisible();
                              },
                              child: Icon(isVisibleIcon)),
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
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25, ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        await processCredentials(_emailController.text, _passwordController.text);
                      } else {
                        alertNotification(context, Colors.red, 'Fields cannot be Empty');
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(child: Text('Login', style: TextStyle(color: Colors.white), )),
                    ),
                  )
                ],
            ),
          ),
        )
      ),
    );
  }

  processCredentials(String email, String password) async {
    bool emailValid =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (password.isNotEmpty && emailValid) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else if (password.isEmpty) {
      alertNotification(context, Colors.red, 'Password cannot be Empty.');
    } else if (!emailValid) {
      alertNotification(context, Colors.red, 'Enter a valid Email Address.');
    } else {
      alertNotification(context, Colors.red, 'Something went wrong.');
    }
  }
}