import 'package:ecommerce/static_methods.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatefulWidget {
  static String id = 'basket_screen';

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticMethods.myAppBar('Basket Screen'),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
