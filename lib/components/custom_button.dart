import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;

  MyButton({@required this.text, this.color,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color ?? Colors.blueAccent,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: kHeaderTextStyle.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
