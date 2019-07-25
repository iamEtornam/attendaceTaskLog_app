import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Ionicons.getIconData('ios-sad'),
          size: 50,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Something went wrong!',
          style: TextStyle(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
