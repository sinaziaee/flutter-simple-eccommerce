import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType inputType;
  final int minLines;
  final double height;

  MyTextField({this.controller, this.text, this.inputType, this.minLines, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      child: TextFormField(
        cursorColor: Colors.black,
        minLines: minLines ?? 1,
        maxLines: 10,
        keyboardType: inputType ?? TextInputType.text,
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
