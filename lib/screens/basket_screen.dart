import 'package:ecommerce/components/bucket_item.dart';
import 'package:ecommerce/models/item.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatefulWidget {
  static String id = 'basket_screen';

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  Size size;
  int count = 0;
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    calculatePrice();
    return Scaffold(
      appBar: StaticMethods.myAppBar('Basket Screen'),
      body: Column(
        children: [
          if (BucketList.itemsCount.length == 0) ...[
            Expanded(
              child: Center(
                child: Text('No item found in your basket'),
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return BucketItem(
                    item: BucketList.items[index],
                    size: size,
                    count: BucketList.itemsCount[index],
                    onDecrease: () {
                      setState(() {
                        if (BucketList.itemsCount[index] > 0) {
                          BucketList.itemsCount[index]--;
                        }
                      });
                    },
                    onIncrease: () {
                      setState(() {
                        BucketList.itemsCount[index]++;
                      });
                    },
                  );
                },
                itemCount: BucketList.items.length,
              ),
            ),
          ],
          bottomContainer(),
        ],
      ),
    );
  }

  bottomContainer() {
    return Column(
      children: [
        Text(totalPrice.toString() ?? 'N/A'),
        ElevatedButton(
          onPressed: () {
            onBuyPressed();
          },
          child: Text('Buy'),
        ),
      ],
    );
  }

  calculatePrice() {
    totalPrice = 0;
    for (int i=0;i<BucketList.itemsCount.length;i++){
      totalPrice += BucketList.items[i].price * BucketList.itemsCount[i];
    }
  }

  onBuyPressed() {
  }
}
