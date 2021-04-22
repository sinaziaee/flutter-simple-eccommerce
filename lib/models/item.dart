import 'package:flutter/material.dart';

class Item {
  String name;
  String description;
  int price;
  String id;
  String url;

  Item({
    @required this.id,
    this.name,
    this.description,
    this.price,
    this.url,
  });
}

class BucketList{
  static List<Item> items;
  static List<int> itemsCount;
}
