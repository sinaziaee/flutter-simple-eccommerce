import 'package:ecommerce/screens/add_item_screen.dart';
import 'package:ecommerce/screens/basket_screen.dart';
import 'package:ecommerce/screens/chat_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Map args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

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
    );
  }

  logOut() {
    auth.signOut();
    StaticMethods.simplePopAndPushNavigation(
        context: context, routeName: LoginScreen.id);
  }

  onBasketPressed(){
    Navigator.pushNamed(context, BasketScreen.id);
  }

  onAddPressed(){
    Navigator.pushNamed(context, AddItemScreen.id);
  }

}
