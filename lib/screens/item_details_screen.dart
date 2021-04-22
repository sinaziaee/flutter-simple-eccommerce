import 'package:ecommerce/models/item.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatefulWidget {
  static String id = 'item_detail_screen';
  Item item;

  ItemDetailScreen(this.item);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.item == null) {
      widget.item = Item(
        url: '',
        description: 'description',
        name: 'name',
        id: '2',
        price: 1000,
      );
    }
    return Scaffold(
      appBar: StaticMethods.myAppBar('Item Detail Screen'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage:
                    (widget.item.url != null || widget.item.url.length != 0)
                        ? NetworkImage(widget.item.url)
                        : AssetImage('assets/images/person.png'),
                radius: 80,
              ),
              Text(widget.item.name),
              Text(widget.item.description),
              Text(widget.item.price.toString()),
              ElevatedButton(
                onPressed: () {
                  onAddToBasketPressed(widget.item);
                },
                child: Text('Add to Basket'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddToBasketPressed(Item item) {
    if(StaticMethods.onBucketAddedPressed(item)){
      setState(() {});
    }
  }
}
