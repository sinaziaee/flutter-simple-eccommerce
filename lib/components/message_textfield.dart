import 'package:flutter/material.dart';

import '../constants.dart';

class CustomMessageTextField extends StatelessWidget {

  final TextEditingController controller;
  final Function onSendPressed;

  CustomMessageTextField({@required this.controller, @required this.onSendPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextField(
            cursorColor: Colors.black,
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Enter your messages...',
              contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              border: kOutLineInputBorder.copyWith(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              focusedBorder: kOutLineInputBorder.copyWith(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: onSendPressed,
        ),
      ],
    );
  }
}
