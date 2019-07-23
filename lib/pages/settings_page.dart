import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
        children: <Widget>[
                   ListTile(
            onTap: () {
            },
            title: Text('FAQ'),
            leading: Icon(AntDesign.getIconData('questioncircle'))
          ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child:   Divider(),
),
          ListTile(
            onTap: () {
            },
            title: Text('Contact Us'),
            leading: Icon(
                Platform.isIOS ? Ionicons.getIconData('ios-contacts'):Icons.people
                  )
          ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child:   Divider(),
),
       ListTile(
            onTap: () {
            },
            title: Text('Terms & Privacy Policy'),
            leading: Icon(Icons.security)
          ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child:   Divider(),
),
       ListTile(
            onTap: () {
            },
            title: Text('Licenses'),
            leading: Icon(Entypo.getIconData('news'))
          ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child:   Divider(),
)
        ],
      ),
      ),
    );
  }
}