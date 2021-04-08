import 'package:flutter/material.dart';

final kOutLineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final kHeaderTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

final kCustomAppBarDecoration = BoxDecoration(
  color: Colors.blueAccent,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)
  ),
);