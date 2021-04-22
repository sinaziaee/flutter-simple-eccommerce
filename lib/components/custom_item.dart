import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/item.dart';
import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final Function onPressed;
  final Item item;

  CustomItem({this.onPressed, this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/person.png'),
                    image: (item.url != null && item.url.length != 0)
                        ? NetworkImage(item.url)
                        : AssetImage('assets/images/person.png'),
                  ),
                ),
                Text(
                  item.name,
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${item.price.toString()} \$',
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
