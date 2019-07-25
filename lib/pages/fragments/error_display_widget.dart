import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(
              Ionicons.getIconData('ios-sad'),
              size: 50,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'No data at the moment!',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
