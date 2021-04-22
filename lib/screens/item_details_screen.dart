import 'package:flutter/material.dart';

class ItemDetailScreen extends StatefulWidget {
  static String id = 'item_detail_screen';

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          
        ),
      ),
    );
  }
}
