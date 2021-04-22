import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String url;
  final Function onPressed;
  final String name;
  final int price;

  CustomItem({this.price, this.name, this.url, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/images/person.png'),
                image: NetworkImage(url),
              ),
              Text(
                name,
                style: kHeaderTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                price.toString(),
                style: kHeaderTextStyle.copyWith(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
