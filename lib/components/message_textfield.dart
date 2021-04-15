import 'package:flutter/material.dart';

import '../constants.dart';

class CustomMessageTextField extends StatelessWidget {

  final TextEditingController controller;
  final Function onSendPressed;

  CustomMessageTextField({@required this.controller, @required this.onSendPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(top: 1),
      child: Container(
        height: 51,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: TextField(
                  cursorColor: Colors.black,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter your messages...',
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
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}