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
                    placeholder: AssetImage('assets/images/person.png'),
                    image: (url != null && url.length != 0)
                        ? NetworkImage(url)
                        : AssetImage('assets/images/person.png'),
                  ),
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
      ),
    );
  }
}
