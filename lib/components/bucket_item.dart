import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BucketItem extends StatelessWidget {
  final Function onIncrease, onDecrease;
  final Size size;

  final int count;
  final Item item;

  BucketItem(
      {this.item, this.count, this.size, this.onDecrease, this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: (item.url != null || item.url.length != 0)
              ? NetworkImage(item.url)
              : AssetImage('assets/images/person.png'),
        ),
        title: Text(
          item.name ?? 'text',
          style: kHeaderTextStyle.copyWith(
            color: Colors.blueGrey[800],
          ),
        ),
        subtitle: Text(
          item.price.toString() ?? '000'
        ),
        trailing: Container(
          width: 210,
          child: Row(
            children: [
              MyCircleButton(
                onPressed: onIncrease,
                iconData: FontAwesomeIcons.plus,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                count.toString() ?? 'text',
                style: kHeaderTextStyle.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              MyCircleButton(
                onPressed: onDecrease,
                iconData: FontAwesomeIcons.minus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCircleButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;

  MyCircleButton({this.onPressed, this.iconData});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(
        side: BorderSide(
          width: 1,
          color: Colors.blueGrey,
        ),
      ),
      onPressed: onPressed,
      child: Icon(iconData),
    );
  }
}
