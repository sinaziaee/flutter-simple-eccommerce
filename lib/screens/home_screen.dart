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

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }

  logOut(){
    auth.signOut();
    StaticMethods.simplePopAndPushNavigation(
        context: context, routeName: LoginScreen.id);
  }

}
