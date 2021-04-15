import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../static_methods.dart';

class ChatScreen extends StatefulWidget {

  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestore = FirebaseFirestore.instance;
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticMethods.myAppBar('Chat Screen'),
      body: Column(
        children: [
          Expanded(
            child: chatHolder(),
          ),
          textFieldHolder(),
        ],
      ),
    );
  }

  Widget chatHolder() {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          final messages = snapshot.data.docs;
          print(messages);
          return ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox();
            },
          );
        } else {
          return Center(child: kCustomProgressIndicator);
        }
      },
      stream: firestore.collection('chats').snapshots(),
    );
  }

  Widget textFieldHolder() {
    return Container(
      child: TextField(
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Enter your messages',
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 20,
          ),
          border: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
