import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class StaticMethods {
  static void showErrorDialog(
      {@required BuildContext context, @required String text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            text,
            style: kHeaderTextStyle.copyWith(),
          ),
          content: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  static void simplePopAndPushNavigation(
      {@required BuildContext context, @required String routeName}) {
    Navigator.popAndPushNamed(context, routeName);
  }

  static PreferredSize myAppBar(String text){
    return PreferredSize(
      child: Container(
        decoration: kCustomAppBarDecoration,
        child: SafeArea(
          child: Container(
            decoration: kCustomAppBarDecoration,
            child: Center(
              child: Text(
                text,
                style: kHeaderTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      preferredSize: Size(
        double.infinity,
        70,
      ),
    );
  }

}
