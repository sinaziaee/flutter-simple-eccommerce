import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {

  final Function onItemPressed;

  BottomContainer({@required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40,
          width: 150,
          margin: EdgeInsets.only(right: 20),
          child: ElevatedButton(
            onPressed: onItemPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text('Add Item'),
          ),
        ),
      ],
    );
  }
}
