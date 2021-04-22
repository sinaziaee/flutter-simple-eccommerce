import 'package:ecommerce/components/custom_item.dart';
import 'package:ecommerce/components/custom_more_row.dart';
import 'package:ecommerce/models/item.dart';
import 'package:ecommerce/screens/add_item_screen.dart';
import 'package:ecommerce/screens/basket_screen.dart';
import 'package:ecommerce/screens/chat_screen.dart';
import 'package:ecommerce/screens/item_details_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/more_items_screen.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Map args;
  Size size;

  @override
  void initState() {
    BucketList.items = [];
    BucketList.itemsCount = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onAddPressed();
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.shopping_basket),
          onPressed: () {
            onBasketPressed();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ChatScreen.id);
        },
        child: Icon(Icons.chat),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customBanner(),
            CustomMoreRow(
              text: 'Recommended for you',
              onMorePressed: () {
                onMorePressed('recommended');
              },
            ),
            customListView(),
            CustomMoreRow(
              text: 'Most Expensive',
              onMorePressed: () {
                onMorePressed('expensive');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customListView() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CustomItem(
            onPressed: () {
              onItemPressed(
                Item(
                  name: 'name',
                  description: 'description',
                  url: '',
                  price: 50,
                  id: '1',
                ),
              );
            },
            name: 'Lap top',
            price: 50,
            url: '',
          ),
        ],
      ),
    );
  }

  onItemPressed(Item item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetailScreen(item);
    }));
  }

  Widget customBanner() {
    return Container(
      color: Colors.grey,
      height: size.height * 0.3,
    );
  }

  logOut() {
    auth.signOut();
    StaticMethods.simplePopAndPushNavigation(
        context: context, routeName: LoginScreen.id);
  }

  onBasketPressed() {
    Navigator.pushNamed(context, BasketScreen.id);
  }

  onAddPressed() {
    Navigator.pushNamed(context, AddItemScreen.id);
  }

  void onMorePressed(String type) {
    Navigator.pushNamed(
      context,
      MoreItemsScreen.id,
      arguments: {
        'type': type,
      },
    );
  }
}
