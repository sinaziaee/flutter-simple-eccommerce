import 'package:flutter/material.dart';

class CustomMoreRow extends StatelessWidget {
  final Function onMorePressed;
  final String text;

  CustomMoreRow({this.onMorePressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: [
          Text(text),
          Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_right_alt_outlined),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}
