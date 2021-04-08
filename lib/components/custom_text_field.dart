import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  MyTextField({this.controller, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
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
    );
  }
}
