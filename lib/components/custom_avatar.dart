import 'dart:io';

import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Function onImageSelectPressed;
  final File imageFile;

  CustomAvatar({@required this.onImageSelectPressed, @required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (imageFile != null) ...[
                new Container(
                  // width: 140.0,
                  // height: 140.0,
                  child: CircleAvatar(
                    radius: 81,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: FileImage(imageFile),
                    ),
                  ),
                ),
              ] else ...[
                new Container(
                  // width: 140.0,
                  // height: 140.0,
                  child: CircleAvatar(
                    radius: 81,
                    child: CircleAvatar(
                      radius: 79,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/person.png'),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 115.0, right: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: onImageSelectPressed,
                  height: 50,
                  shape: CircleBorder(),
                  color: Colors.blue,
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
